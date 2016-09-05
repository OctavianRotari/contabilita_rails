$(document).ready(
	function() {
		$('.popup-with-form').magnificPopup({
			type: 'inline',
			preloader: false,
			focus: '#name',
			// When elemened is focused, some mobile browsers in some cases zoom in
			// It looks not nice, so we disable it:
			callbacks: {
				beforeOpen: function() {
					if($(window).width() < 700) {
						this.st.focus = false;
					} else {
						this.st.focus = '#name';
					}
				},
			}
		});
		$('#add_category').click(function() {
				$.ajax({
					type: "POST",
					url: "/category_of_companies",
					dataType: 'html',
					data: { category: $('#category_of_company_category').val() },
					success: function(data){
						alert('ok');
						alert(data); // show response from the php script.
					},
					error: function(data) {
						alert('not ok');
						alert(data); // show response from the php script.
					}
				});
		});
	}
);
