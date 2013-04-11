create or replace function get_initials(input_string in varchar2) return varchar2 as
    tmp varchar2(64); rv varchar2(64); c char; pos int;
begin
    rv := ''; tmp := input_string;
    loop
        -- grab first char, if it's in [A-Z]
        c := substr(tmp,1,1);
        if ascii(c) >= 65 and ascii(c) <= 90 then rv := rv || c; end if;
        -- next word, or done
        pos := instr(tmp,' ');
        if pos > 0 then tmp := substr(tmp,instr(tmp,' ')+1); 
        else exit;
        end if;
    end loop;
    return rv;
end;
