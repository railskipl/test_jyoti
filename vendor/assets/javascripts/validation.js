 $(document).ready(function () {
    //validation for tasks form
    $(".new_user").click(function(e){
        $("[generated=true]").remove();
        $("#contactus").validate({
            rules: {
                "user[email]": {
                    required: true
                },
                "user[password]": {
                    required: true
                }
            },
            messages: {
                "user[email]": {
                    required: "Email cannot be blank"
                },

                "user[password]": {
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

    jQuery("#edit_user").validate({
    errorElement:'div',
    rules: {
      "user[city]":{
                      required: true
                }   
        },
    messages: {
    "user[city]":{
                      required: "City cannot be blank!"
                     
                }  
        }
    });
   
});
