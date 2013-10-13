CREATE OR REPLACE FUNCTION HASH_TEXT(	p_input_string in varchar2,
										                  p_mode in varchar2) RETURN VARCHAR2
is
	output_str_md5  varchar2(200);
	output_str_sh1  varchar2(200);
	hash_raw_md5       raw(2000);
	hash_raw_sh1       raw(2000);
	hash_algo_type1 pls_integer := dbms_crypto.hash_md5;
	hash_algo_type2 pls_integer := dbms_crypto.hash_sh1;
begin

	hash_raw_md5 := dbms_crypto.hash( src    => utl_raw.cast_to_raw(p_input_string), 
									                  typ    => hash_algo_type1);
	hash_raw_sh1  := dbms_crypto.hash(src => utl_raw.cast_to_raw(p_input_string),
									                  typ => hash_algo_type2);

	output_str_md5 :=  lower(rawtohex(hash_raw_md5));
	output_str_sh1 :=  lower(rawtohex(hash_raw_sh1));

	IF upper(p_mode) = 'SH1' THEN
		RETURN output_str_sh1;
	elsif upper(p_mode) = 'MD5' THEN
		RETURN output_str_md5;
	ELSE
		RETURN NULL;
	END IF;

end;
/
