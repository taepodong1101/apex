CREATE OR REPLACE  FUNCTION string_occurrence(p_string IN VARCHAR2, p_search IN VARCHAR2)
    RETURN NUMBER IS
    v_occurrence     NUMBER := 0;
    v_start_position NUMBER;
    v_look_for       VARCHAR2(4000);
    v_no_of_words    NUMBER := 0;
    v_word_found_cnt NUMBER := 0;

  BEGIN

    v_no_of_words := (LENGTH(p_search) -
                     NVL(LENGTH(REPLACE(p_search, ' ', '')), 0)) / LENGTH(' ');
    FOR i IN 1 .. v_no_of_words LOOP
      IF i = 1 THEN
        v_start_position := 1;
      ELSE
        v_start_position := instr(p_search, ' ', 1, i - 1);
      END IF;

      v_look_for := TRIM(substr(p_search,
                                v_start_position,
                                instr(p_search, ' ', 1, i) - v_start_position));

      v_occurrence := (LENGTH(p_string) - NVL(LENGTH(REPLACE(upper(p_string),
                                                             upper(v_look_for),
                                                             '')),
                                              0)) / LENGTH(v_look_for);

      IF v_occurrence > 0 THEN
        v_word_found_cnt := v_word_found_cnt + 1;
      END IF;
    END LOOP;

    IF v_word_found_cnt >= v_no_of_words THEN
      RETURN v_word_found_cnt;
    ELSE
      RETURN 0;
    END IF;

  END string_occurrence;
