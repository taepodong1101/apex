DECLARE
  l_vc_arr2	APEX_APPLICATION_GLOBAL.VC_ARR2;
--  l_vc_arr2 	APEX_APPLICATION_GLOBAL.N_ARR;
  TYPE tab_num is TABLE OF NUMBER;
  s_codes tab_num	:= tab_num();
  
  entry_count NUMBER;
BEGIN
  
  IF :P10_USER_TYPE_ID = 4 THEN 

  	l_vc_arr2 := APEX_UTIL.STRING_TO_TABLE(:P10_USER_CODES); -- SHUTTLE OR MULTI-SELECT PICK LIST, PRODUCES COLON SEPERATED VALUES

  	-- deletions
  	-- populate number table
  	FOR i IN 1..l_vc_arr2.COUNT LOOP
  		s_codes.EXTEND;
  		s_codes(i):= CAST(l_vc_arr2(i) AS NUMBER);
  	END LOOP;
  	
  	FOR j IN (select project_code_id from TS_USER_PROJECT_CODE_R where user_id=:P10_USER_ID) LOOP
  		IF j.project_code_id MEMBER OF s_codes THEN
  			null;
  		else
  			DELETE FROM TS_USER_PROJECT_CODE_R WHERE PROJECT_CODE_ID = j.project_code_id AND USER_ID = :P10_USER_ID;
  			COMMIT;
  		END IF;
  	END LOOP;
  	
  	-- inserts
  	FOR z IN 1..l_vc_arr2.count LOOP
  		entry_count:=0;
  		
  		select count(*) into entry_count FROM TS_USER_PROJECT_CODE_R WHERE user_id = :P10_USER_ID AND PROJECT_CODE_ID = l_vc_arr2(z);
  		
  		IF entry_count = 0 THEN
  			INSERT INTO TS_USER_PROJECT_CODE_R (USER_ID, PROJECT_CODE_ID) VALUES (:P10_USER_ID, l_vc_arr2(z));
  			COMMIT;
  		END IF;
  		
  	END LOOP;
  	
  END IF;
  	
END;
