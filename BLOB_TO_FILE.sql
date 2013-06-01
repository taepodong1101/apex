-- procedure to copy files to file system
-- Credits: decasse from OTN Forums: https://forums.oracle.com/forums/thread.jspa?threadID=634578

 Procedure BLOB_TO_FILE(p_file_name In Varchar2) Is
    l_out_file    UTL_FILE.file_type;
    l_buffer      Raw(32767);
    l_amount      Binary_Integer := 32767;
    l_pos         Integer := 1;
    l_blob_len    Integer;
    p_data        Blob;
    file_name  Varchar2(256);
 
  Begin
    For rec In (Select ID
                          From HTMLDB_APPLICATION_FILES
                         Where Name = p_file_name)
    Loop
        Select BLOB_CONTENT, filename Into p_data, file_name From HTMLDB_APPLICATION_FILES Where ID = rec.ID;
        --
        l_blob_len := DBMS_LOB.getlength(p_data);
        l_out_file := UTL_FILE.fopen('UPDOWNFILES_DIR', file_name, 'wb', 32767);
        --
        While l_pos < l_blob_len
        Loop
          DBMS_LOB.Read(p_data, l_amount, l_pos, l_buffer);
          If l_buffer Is Not Null Then
            UTL_FILE.put_raw(l_out_file, l_buffer, True);
          End If;
          l_pos := l_pos + l_amount;
        End Loop;
        --
        UTL_FILE.fclose(l_out_file);
        --------------
    End Loop;          
  Exception
    When Others Then
      If UTL_FILE.is_open(l_out_file) Then
        UTL_FILE.fclose(l_out_file);
      End If;
  end; 
