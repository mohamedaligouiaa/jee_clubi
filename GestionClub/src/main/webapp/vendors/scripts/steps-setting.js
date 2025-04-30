$(".tab-wizard").steps({
	headerTag: "h5",
	bodyTag: "section",
	transitionEffect: "fade",
	titleTemplate: '<span class="step">#index#</span> #title#',
	labels: {
		finish: "Submit"
	},
	onStepChanged: function (event, currentIndex, priorIndex) {
		$('.steps .current').prevAll().addClass('disabled');
	},
	onFinished: function (event, currentIndex) {
		$('#success-modal').modal('show');
	}
});

$(".tab-wizard2").steps({
    headerTag: "h5",
    bodyTag: "section",
    transitionEffect: "fade",
    titleTemplate: '<span class="step">#index#</span> <span class="info">#title#</span>',
    labels: {
        finish: "Submit",
        next: "Next",
        previous: "Previous",
    },
    onStepChanged: function(event, currentIndex, priorIndex) {
    $('.steps .current').prevAll().addClass('disabled');

    // Mettre à jour l'Overview Information à l'étape 3
    if (currentIndex === 2) { 
        $("#overview-email").text($("input[name='email']").val());
        $("#overview-username").text($("input[name='username']").val());
        $("#overview-password").text("*******"); 
        $("#overview-fullname").text($("input[name='full_name']").val());
        $("#overview-location").text($("input[name='city']").val());
    }
},
    onFinished: function(event, currentIndex) {
        let isValid = true;

        $(".tab-wizard2 input").each(function () {
            if ($(this).val().trim() === "") {
                isValid = false;
                $(this).css("border", "1px solid red");
            } else {
                $(this).css("border", "");
            }
        });

        let password = $("input[name='password']").val();
        let confirmPassword = $("input[name='confirmpassword']").val();

        if (password !== confirmPassword) {
            alert("Les mots de passe ne correspondent pas !");
            isValid = false;
        }

        if (!$("#customCheck1").is(":checked")) {
            alert("Vous devez accepter les conditions d'utilisation !");
            isValid = false;
        }

        if (isValid) {
            $(".tab-wizard2").submit();
        } else {
            alert("Veuillez remplir tous les champs !");
        }
    }
});
