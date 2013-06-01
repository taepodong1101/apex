<script type="text/javascript">
// Makes it IE compatible. 
// Requires a button to shut close as Fade in removed.


function openModal3(p_div_id)
{
// added - ensures user can open one modal at a time, so one opens, existing one closes
closeModal();
 
  //gBackground.fadeIn(100); --> commented out
	gLightbox = jQuery('#' + p_div_id);
	gLightbox.addClass('modalOn');
}
 
 
 
</script>
