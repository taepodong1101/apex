create or replace FUNCTION item_in_list(p_num IN NUMBER, p_list in VARCHAR2)
RETURN NUMBER
IS
    l_vc_arr2    APEX_APPLICATION_GLOBAL.VC_ARR2;
    
    TYPE number_list is TABLE OF NUMBER;
    num_list number_list := number_list();
    
    x_ret NUMBER;
BEGIN
    /* checks if p_num exists in the colon delimited list p_list */
    
        l_vc_arr2 := APEX_UTIL.STRING_TO_TABLE(p_list);
        
        FOR i IN 1..l_vc_arr2.COUNT LOOP
            num_list.EXTEND;
            num_list(i):= CAST(l_vc_arr2(i) AS NUMBER);
        END LOOP;
        
        IF p_num MEMBER OF num_list then 
            return 1;
        else
            return 0;
        end if;
 
 
END;
