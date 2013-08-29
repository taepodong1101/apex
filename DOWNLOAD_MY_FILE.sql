-- Download file from file system
-- Credits: decasse from OTN forum: https://kr.forums.oracle.com/forums/thread.jspa?threadID=634578


    Procedure download_my_file( p_file In Number) As
                                v_length    Number;
                                v_file_name Varchar2(2000);
                                Lob_loc     Bfile;
  
  Begin
    SELECT file_name
    INTO v_file_name
    FROM UpDownFiles F
    WHERE File_id = p_file;
  
    Lob_loc  := bfilename('UPDOWNFILES_DIR', v_file_name);
    v_length := dbms_lob.getlength(Lob_loc);
  
    owa_util.mime_header('application/octet', False);
    htp.p('Content-length: ' || v_length);
    htp.p('Content-Disposition: attachment; filename="' || SUBSTR(v_file_name, INSTR(v_file_name, '/') + 1) || '"'); 
    owa_util.http_header_close;
    wpg_docload.download_file(Lob_loc);
   
  END download_my_file;
