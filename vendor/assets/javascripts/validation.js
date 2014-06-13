// sign up validations
    $("#feedback").validate({
    errorElement:'span',
    rules: {


    "feedback[name]" :{
    required: true

    },

    "feedback[email]" :{
    required: true

    },

    

    "feedback[description]" :{
    required: true

    },
    messages: {

    "feedback[name]" :{
    required: "Please enter name"

    },
    "feedback[email]" :{
    required: "Please enter email"

    },

    "feedback[description]" :{
    required: "Please add feedback."

    },
 
 

    "feedback[email]" :{
    required: "Please enter your Email Address",
     email: "Please enter Valid Email Id",
     /* remote:"email id already exists" */
    },

    

      }



   });











    $("#new_page").validate({
    errorElement:'span',
    rules: {


    "page[title]" :{
    required: true

    },

    "page[body]" :{
    required: true

    },

    

    "page[photo]" :{
    required: true

    },
    messages: {

    "page[title]" :{
    required: "Please enter name"

    },
    "page[body]" :{
    required: "Please enter email"

    },

    "page[photo]" :{
    required: "Please add feedback."

    },

   }

 });