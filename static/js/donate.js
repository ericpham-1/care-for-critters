document.addEventListener('DOMContentLoaded', () => {
  const amountButtons = document.querySelectorAll('.amount-btn');
  const otherAmountInput = document.getElementById('otherAmount');
  const donationAmountInput = document.getElementById('donationAmount');


                // Page 1 Scripts //
  const page1 = document.getElementById("step1Form")
  if (page1) {
    amountButtons.forEach(button => {
      button.addEventListener('click', () => {
        // Remove .selected class & aria-pressed from all buttons
        amountButtons.forEach(btn => {
          btn.classList.remove('selected');
          btn.setAttribute('aria-pressed', 'false');
        });

        // Clear custom amount input
        otherAmountInput.value = '';

        // Add .selected class & aria-pressed to clicked button
        button.classList.add('selected');
        button.setAttribute('aria-pressed', 'true');

        // Update hidden input with the selected amount
        donationAmountInput.value = button.getAttribute('data-value');
      });
    });
    
    otherAmountInput.addEventListener('input', () => {
    // Remove selection from all amount buttons
    amountButtons.forEach(btn => {
      btn.classList.remove('selected');
      btn.setAttribute('aria-pressed', 'false');
    });

    if (otherAmountInput.value.trim() !== '') {
      // Add a "selected" style to the custom amount input container (optional)
      otherAmountInput.parentElement.classList.add('selected');
    } else {
      otherAmountInput.parentElement.classList.remove('selected');
    }

    // Update hidden input value to whatever user types
    donationAmountInput.value = otherAmountInput.value;
  });
  }

                  // Page 2 Scripts //
const page2 = document.querySelector("step2Form");
    if (page2) {
        const errorBox = document.getElementById("error-message");

        page2Form.addEventListener("submit", (e) => {
            const requiredFields = [
                "first_name",
                "last_name",
                "email",
                "phone_number"
            ];
            
            errorBox.textContent = "";

            for (let field of requiredFields) {
                const input = document.querySelector(`input[name="${field}"]`);
                if (!input || !input.value.trim()) {
                    e.preventDefault();
                    errorBox.textContent = "Please fill out all fields.";
                    return;
                }
            }
        });
    }
  

});

