var currentTab = 0; // Current tab is set to be the first tab (0)
showTab(currentTab); // Display the current tab

function showTab(step_number) {
    var tabs = document.getElementsByClassName("tab");
    tabs[step_number].style.display = "block";
    // ... and fix the Previous/Next buttons:
    if (step_number == 0) {
        document.getElementById("prevBtn").style.display = "none";
    } else {
        document.getElementById("prevBtn").style.display = "inline";
    }
    if (step_number == (tabs.length - 1)) {
        document.getElementById("nextBtn").innerHTML = "Submit";
    } else {
        document.getElementById("nextBtn").innerHTML = "Next";
    }
    // ... and run a function that displays the correct step indicator:
    fixStepIndicator(step_number)
}

function nextPrev(n) {
    // This function will figure out which tab to display
    var x = document.getElementsByClassName("tab");
    // Exit the function if any field in the current tab is invalid:
    if (n == 1 && !validateForm()) return false;
    // Hide the current tab:
    x[currentTab].style.display = "none";
    // Increase or decrease the current tab by 1:
    currentTab = currentTab + n;
    // if you have reached the end of the form... :
    if (currentTab >= x.length) {
        //...the form gets submitted:
        document.getElementById("new_travel").submit();
        return false;
    }
    // Otherwise, display the correct tab:
    showTab(currentTab);
}

function validateForm() {
    var tabs, inputs, i, valid = true;
    tabs = document.getElementsByClassName("tab");
    inputs = tabs[currentTab].getElementsByTagName("input");
    
    for (i = 0; i < inputs.length; i++) {
        if (inputs[i].value == "") {
            inputs[i].className += " invalid";
            valid = false;
        }
    }
    if (valid) {
        document.getElementsByClassName("step")[currentTab].className += " finish";
    }
    return valid; // return the valid status
}

function fixStepIndicator(n) {
    // This function removes the "active" class of all steps...
    var i, steps = document.getElementsByClassName("step");
    for (i = 0; i < steps.length; i++) {
        steps[i].className = steps[i].className.replace(" active", "");
    }
    //... and adds the "active" class to the current step:
    steps[n].className += " active";
}

function wait(ms) {
  var start = new Date().getTime();
  var end = start;
  while (end < start + ms) {
    end = new Date().getTime();
  }
}