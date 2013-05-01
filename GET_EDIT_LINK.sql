    function  get_edit_link(p_order_id number) 
    return varchar2
    IS
        r_link varchar2(500);
        
        l_target varchar2(1000);
        l_app number := v('APP_ID');
        l_session number := v('APP_SESSION');
        l_user VARCHAR2(500) := v('APP_USER');
        
        l_has_permission NUMBER := 0;
        
    begin
        
    l_target := APEX_UTIL.PREPARE_URL(
                                    p_url => 'f?p=' || l_app || ':21:'||l_session||'::NO::P21_ORDER_ID:'||p_order_id,
                                    p_checksum_type => 'SESSION');
    
    
    
    
    r_link := '<a href="'||l_target||'">'||p_order_id||'</a>';
    
    
    
    
    
    
    case 
    when  orders.check_order_association(p_order_id, l_user) = 1 then
        return r_link;
    ELSE
        return to_char(p_order_id);
    end CASE;
    
    
    end get_edit_link;
