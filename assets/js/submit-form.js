$(function () {
  'use strict';
  const forms = $('.needs-validation');

  forms.on('submit', function (event) {
    const form = $(this);
    const actionInput = form.find("input[name='action']");
    const submitBtn = form.find('.submit_form, .submit_subscribe');
    const btnText = submitBtn.find('.btn-text'); // only replace text inside span

    if (!form[0].checkValidity()) {
      event.preventDefault();
      event.stopPropagation();
    } else {
      event.preventDefault();

      // change only the text
      btnText.text('Sending...');

      $.ajax({
        type: "POST",
        url: "php/form_process.php",
        data: form.serialize(),
        success: function (response) {
          if (response === 'success') {
            if (actionInput.val() === 'subscribe') {
              btnText.text('Subscribe');
              const toast = new bootstrap.Toast($('.success_msg_subscribe')[0]);
              toast.show();
            } else {
              btnText.text('Send Message');
              const toast = new bootstrap.Toast($('.success_msg')[0]);
              toast.show();
            }
          } else {
            btnText.text(actionInput.val() === 'subscribe' ? 'Subscribe' : 'Send Message');
            if (actionInput.val() !== 'subscribe') {
              const errtoast = new bootstrap.Toast($('.error_msg')[0]);
              errtoast.show();
            }
          }
        },
        error: function () {
          btnText.text(actionInput.val() === 'subscribe' ? 'Subscribe' : 'Send Message');
          if (actionInput.val() !== 'subscribe') {
            const errtoast = new bootstrap.Toast($('.error_msg')[0]);
            errtoast.show();
          }
        }
      });
    }

    form.addClass('was-validated');
  });
});
