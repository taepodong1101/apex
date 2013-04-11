select 
application_id, 
application_name, 
apex_user,
apex_session_id, 
page_name, 
page_id,
seconds_ago,
(current_timestamp-numtodsinterval(seconds_ago,'SECOND')) as activity_time,
to_char(round((seconds_ago)/3600,2),'9,999.99') as hours_ago,
ERROR_MESSAGE, ERROR_ON_COMPONENT_TYPE, ERROR_ON_COMPONENT_NAME
from apex_workspace_activity_log 
where application_id= :APP_ID