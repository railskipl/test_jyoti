 $(document).ready(function () {
    //validation for tasks form
    $(".contact-form").click(function(e){
        $("[generated=true]").remove();
        $("#contactus").validate({
            rules: {
                "contactus[email]": {
                    required: true
                },
                "contactus[name]": {
                    required: true
                }
            },
            messages: {
                "contactus[email]": {
                    required: "Email cannot be blank"
                },

                "contactus[name]": {
                    required: "Name is required"
                }
            }
        }); 
     });




    $(".power_group").click(function(e){
        $("[generated=true]").remove();
        $("#relationship").validate({
            rules: {
                "relationship_ids[]": {
                    required: true
                },
                
            },
            messages: {
                "relationship_ids[]": {
                    required: "Please Select Email"
                },

                
            }
        }); 
     });
   

    });
