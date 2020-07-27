function validateFormOnSubmit(theForm) {
    var reason = "";

    reason += validateUsername(theForm.username);
    reason += validateEmail(theForm.email);
    reason +=validatePassword(theForm.password,theForm.confirm_pass);
    reason +=validatePhone(theForm.phone);
    reason +=validateName(theForm.firstname);
    reason +=validateSurname(theForm.lastname);
    reason +=validateCity(theForm.city);
    reason +=validateAddress(theForm.street);
    reason +=validateMobilePhone(theForm.mobile);
    reason +=validateZipCode(theForm.zip);

  if (reason != "") {
    return false;
  }

  return true;
}

function validateForm(theForm) {
    var val = "";

    if (theForm.password.value!="" || theForm.confirm_pass.value!="" ){
        val +=validatePassword(theForm.password,theForm.confirm_pass);
    }
    val += validateEmail(theForm.email);
    val +=validatePhone(theForm.phone);
    val +=validateName(theForm.firstname);
    val +=validateSurname(theForm.lastname);
    val +=validateCity(theForm.city);
    val +=validateAddress(theForm.street);
    val +=validateMobilePhone(theForm.mobile);
    val +=validateZipCode(theForm.zip);

  if (val != "") {
    return false;
  }

  return true;
}

function validateForm(theForm) {
    var val = "";

    if (theForm.password.value!="" || theForm.confirm_pass.value!="" ){
        val +=validatePassword(theForm.password,theForm.confirm_pass);
    }
    val += validateEmail(theForm.email);
    val +=validatePhone(theForm.phone);
    val +=validateName(theForm.firstname);
    val +=validateSurname(theForm.lastname);
    val +=validateCity(theForm.city);
    val +=validateAddress(theForm.street);
    val +=validateMobilePhone(theForm.mobile);
    val +=validateZipCode(theForm.zip);

  if (val != "") {
    return false;
  }

  return true;
}

function validateOrder(theForm) {
    var val = "";

    val +=validateEmail(theForm.email);
    val +=validatePhone(theForm.phone);
    val +=validateName(theForm.firstname);
    val +=validateSurname(theForm.lastname);
    val +=validateCity(theForm.city);
    val +=validateAddress(theForm.street);
    val +=validateMobilePhone(theForm.mobile);
    val +=validateZipCode(theForm.zip);
    if(theForm.pliromi.selectedIndex==1){
        val +=validateCardNumber(theForm.cardnumber);
        val +=validateCvv(theForm.cvv);
        val +=validateCardHolderPhone(theForm.cardholderpho);
        val +=validateCardHolderName(theForm.cardholder);
    }

  if (val != "") {
    return false;
  }

  return true;
}

function validateOnInsertProduct(theForm) {
    var val = "";

    val =checkEmptyFields(theForm.sn,theForm.manufact,theForm.model,theForm.price,theForm.warranty,theForm.stock,theForm.image,theForm.thres,theForm.descript);
    

  if (val != "") {
    return false;
  }

  return true;
}


function checkEmptyFields(sn,manufact,model,price,warranty,stock,image,thres,descript) {
    var error="";
    var illegalChars = /[^0-9 ]/;
    var illegalPrice=/[^0-9.]/
    var obj = document.getElementById('sn_error');
    obj.style.display = 'none';
    obj = document.getElementById('sn_error2');
    obj.style.display = 'none';
    obj = document.getElementById('manufact_error');
    obj.style.display = 'none';
    obj = document.getElementById('model_error');
    obj.style.display = 'none';
    obj = document.getElementById('price_error');
    obj.style.display = 'none';
    obj = document.getElementById('price_error2');
    obj.style.display = 'none';
    obj = document.getElementById('warranty_error');
    obj.style.display = 'none';
    obj = document.getElementById('stock_error');
    obj.style.display = 'none';
    obj = document.getElementById('image_error');
    obj.style.display = 'none';
    obj = document.getElementById('thres_error');
    obj.style.display = 'none';
    obj = document.getElementById('thres_error2');
    obj.style.display = 'none';
    obj = document.getElementById('descript_error');
    obj.style.display = 'none';

    if (sn.value == "") {
        error = "You enter nothing.\n";
        obj = document.getElementById('sn_error');
        sn.style.background='#febcba';
        obj.style.display = 'inline';}
    else if(illegalChars.test(sn.value)){
        error ="Not a number";
        obj = document.getElementById('sn_error2');
        sn.style.background='#febcba';
        obj.style.display = 'inline';}
    else {
        sn.style.background = 'White';
    }
    if (manufact.value == "") {
        error = "You enter nothing.\n";
        obj = document.getElementById('manufact_error');
        manufact.style.background='#febcba';
        obj.style.display = 'inline';}
    else {
        manufact.style.background = 'White';
    }
    if (model.value == "") {
        error = "You enter nothing.\n";
        obj = document.getElementById('model_error');
        model.style.background='#febcba';
        obj.style.display = 'inline';}
    else {
        model.style.background = 'White';
    }
    if (price.value == "") {
        error = "You enter nothing.\n";
        obj = document.getElementById('price_error');
        price.style.background='#febcba';
        obj.style.display = 'inline';}
    else if(illegalPrice.test(price.value)){
        error ="Not a number";
        obj = document.getElementById('price_error2');
        thres.style.background='#febcba';
        obj.style.display = 'inline';}
    else {
        price.style.background = 'White';
    }
    if (warranty.value == "") {
        error = "You enter nothing.\n";
        obj = document.getElementById('warranty_error');
        warranty.style.background='#febcba';
        obj.style.display = 'inline';}
    else {
        warranty.style.background = 'White';
    }
    if (stock.value == "") {
        error = "You enter nothing.\n";
        obj = document.getElementById('stock_error');
        stock.style.background='#febcba';
        obj.style.display = 'inline';}
    else {
        stock.style.background = 'White';
    }
    if (image.value == "") {
        error = "You enter nothing.\n";
        obj = document.getElementById('image_error');
        image.style.background='#febcba';
        obj.style.display = 'inline';}
    else {
        image.style.background = 'White';
    }
    if (thres.value == "") {
        error = "You enter nothing.\n";
        obj = document.getElementById('thres_error');
        thres.style.background='#febcba';
        obj.style.display = 'inline';}
     else if(illegalChars.test(thres.value)){
        error ="Not a number";
        obj = document.getElementById('thres_error2');
        thres.style.background='#febcba';
        obj.style.display = 'inline';}
    else {
        thres.style.background = 'White';
    }
    if (descript.value == "") {
        error = "You enter nothing.\n";
        obj = document.getElementById('descript_error');
        descript.style.background='#febcba';
        obj.style.display = 'inline';}
    else {
        descript.style.background = 'White';
    }
    
    return error;
}



function validateUsername(fld) {
    var error="";
    var illegalChars = /\W/;
    fld.style.background='#febcba';
    var obj = document.getElementById('user_error1');
    obj.style.display = 'none';
    obj = document.getElementById('user_error2');
    obj.style.display = 'none';
    obj = document.getElementById('user_error3');
    if (obj!=null)  obj.style.display = 'none';

    if (fld.value == "") {
        error = "You didn't enter a username.\n";
        obj = document.getElementById('user_error1');
        fld.style.background='#febcba';
        obj.style.display = 'inline';}
    else if(illegalChars.test(fld.value)){
       error ="Your username has special characters.These are not allowed.";
       obj = document.getElementById('user_error2');
       fld.style.background='#febcba';
       obj.style.display = 'inline';}
    else {
        fld.style.background = 'White';
    }

    return error;
}



function validateEmail(fld) {
    var error="";
    var illegalChars = "!#$%^&*()+=-[]\\\';,/{}|\":<>?~_ ";
    var emailFilter = /^[^@]+@[^@.]+\.[^@]*\w\w$/ ;
    var invalidCharFound=0;

    var obj = document.getElementById('email_error1');
    obj.style.display = 'none';
    obj = document.getElementById('email_error2');
    obj.style.display = 'none';
    obj = document.getElementById('email_error3');
    obj.style.display = 'none';
    obj = document.getElementById('email_error4');
    if (obj!=null) obj.style.display = 'none';


    for (var i = 0; i < fld.value.length; i++) {
  	if (illegalChars.indexOf(fld.value.charAt(i)) != -1) {
  	  invalidCharFound=1;
  	}
    }

    if (fld.value == "") {
        error = "You didn't enter an email.\n";
        obj = document.getElementById('email_error1');
        fld.style.background='#febcba';
        obj.style.display = 'inline';
    } else if (invalidCharFound==1) {
        error = "The email contains illegal characters.";
        obj = document.getElementById('email_error2');
        fld.style.background='#febcba';
        obj.style.display = 'inline';
    } else if (!fld.value.match(emailFilter)) {
        error = "The email is not valid.";
        obj = document.getElementById('email_error3');
        fld.style.background='#febcba';
        obj.style.display = 'inline';
    } else {
        fld.style.background = 'White';
    }

    return error;
}

function validatePassword(fld,fld1) {
    var error = "";
    var illegalChars = /[\W_]/; // allow only letters and numbers
    var obj = document.getElementById('pass_error1');
    obj.style.display = 'none';
    obj = document.getElementById('pass_error2');
    obj.style.display = 'none';
    obj = document.getElementById('conf_pass_error');
    obj.style.display = 'none';


    if (fld.value == "") {
        error = "You didn't enter a password.\n";
        fld.style.background='#febcba';
        fld1.style.background='#febcba';
	obj = document.getElementById('pass_error1');
	obj.style.display = 'inline';
    } else if (illegalChars.test(fld.value)) {
        error = "The password contains illegal characters. Password must contain only letters and numbers \n";
        fld.style.background='#febcba';
        fld1.style.background='#febcba';
        obj = document.getElementById('pass_error2');
	obj.style.display = 'inline';
    } else if (fld1.value != fld.value) {
        error = "The password must be the same with the confirmation password";
        fld.style.background='#febcba';
        fld1.style.background='#febcba';
	obj = document.getElementById('conf_pass_error');
	obj.style.display = 'inline';
    }else {
        fld.style.background = 'White';
        fld1.style.background = 'White';
    }
   return error;
}


function validatePhone(fld) {
    var error = "";
    var illegalChars = /[^0-9 ]/;
    var stripped = fld.value.replace(/[\(\)\.\-\ ]/g, '');
    var obj = document.getElementById('phone_error1');
    obj.style.display = 'none';
    obj = document.getElementById('phone_error2');
    obj.style.display = 'none';
    obj = document.getElementById('phone_error3');
    obj.style.display = 'none';

   if (fld.value == "") {
        error = "You didn't enter a phone number.\n";
        fld.style.background='#febcba';
	obj = document.getElementById('phone_error1');
	obj.style.display = 'inline';
    } else if (illegalChars.test(fld.value)) {
        error = "The phone number contains illegal characters.\n";
        fld.style.background='#febcba';
	obj = document.getElementById('phone_error2');
	obj.style.display = 'inline';
    } else if (fld.value == "0") {
        fld.style.background = 'White';
    } else if (!(stripped.length == 10)) {
        error = "The phone number is the wrong length. Make sure you included an area code.\n";
        fld.style.background='#febcba';
	obj = document.getElementById('phone_error3');
	obj.style.display = 'inline';
    }else {
        fld.style.background = 'White';
    }
    return error;
}

function validateName(fld) {
   var error="";
    var illegalChars = /[^a-zA-Zα-ωΑ-ΩάϊέύίόήώΆΈΎΊΌΉΏ]/;

    var obj = document.getElementById('name_error1');
    obj.style.display = 'none';
    obj = document.getElementById('name_error2');
    obj.style.display = 'none';

    if (fld.value == "") {
        error = "You didn't enter a name.\n";
        obj = document.getElementById('name_error1');
        fld.style.background='#febcba';
        obj.style.display = 'inline';}
    else if(illegalChars.test(fld.value)){
       error ="Your name has special characters.These are not allowed.";
       obj = document.getElementById('name_error2');
       fld.style.background='#febcba';
       obj.style.display = 'inline';}
    else {
        fld.style.background = 'White';
    }
    return error;
}

function validateSurname(fld) {
   var error="";
   var illegalChars = /[^a-zA-Zα-ωΑ-ΩϊάέύίόήώΆΈΎΊΌΉΏ]/;

    var obj = document.getElementById('surname_error1');
    obj.style.display = 'none';
    obj = document.getElementById('surname_error2');
    obj.style.display = 'none';

    if (fld.value == "") {
        error = "You didn't enter a name.\n";
        obj = document.getElementById('surname_error1');
        fld.style.background='#febcba';
        obj.style.display = 'inline';}
    else if(illegalChars.test(fld.value)){
       error ="Your name has special characters.These are not allowed.";
       obj = document.getElementById('surname_error2');
       fld.style.background='#febcba';
       obj.style.display = 'inline';}
    else {
        fld.style.background = 'White';
    }
    return error;
}

function validateCity(fld) {
   var error="";
   var illegalChars = /[^a-zA-Zα-ωΑ-ΩϊάέύίόήώΆΈΎΊΌΉΏ]/;

    var obj = document.getElementById('city_error1');
    obj.style.display = 'none';
    obj = document.getElementById('city_error2');
    obj.style.display = 'none';

    if (fld.value == "") {
        error = "You didn't enter a city.\n";
        obj = document.getElementById('city_error1');
        fld.style.background='#febcba';
        obj.style.display = 'inline';}
    else if(illegalChars.test(fld.value)){
       error ="Your city has special characters.These are not allowed.";
       obj = document.getElementById('city_error2');
       fld.style.background='#febcba';
       obj.style.display = 'inline';}
    else {
        fld.style.background = 'White';
    }
    return error;
}

function validateAddress(fld) {
   var error="";
    var illegalChars = /[^a-zA-Zα-ωΑ-Ωϊάέύίόήώ0-9 ]/;

    var obj = document.getElementById('address_error1');
    obj.style.display = 'none';
    obj = document.getElementById('address_error2');
    obj.style.display = 'none';

    if (fld.value == "") {
        error = "You didn't enter an address.\n";
        obj = document.getElementById('address_error1');
        fld.style.background='#febcba';
        obj.style.display = 'inline';}
    else if(illegalChars.test(fld.value)){
       error ="Your address has special characters.These are not allowed.";
       obj = document.getElementById('address_error2');
       fld.style.background='#febcba';
       obj.style.display = 'inline';}
    else {
        fld.style.background = 'White';
    }
    return error;
}

function validateZipCode(fld) {
   var error="";
   var illegalChars = /[^0-9 ]/;

    var obj = document.getElementById('zip_error1');
    obj.style.display = 'none';
    obj = document.getElementById('zip_error2');
    obj.style.display = 'none';

    if (fld.value == "") {
        error = "You didn't enter a zip.\n";
        obj = document.getElementById('zip_error1');
        fld.style.background='#febcba';
        obj.style.display = 'inline';}
    else if(illegalChars.test(fld.value)){
       error ="Your zip has special characters.These are not allowed.";
       obj = document.getElementById('zip_error2');
       fld.style.background='#febcba';
       obj.style.display = 'inline';}
    else {
        fld.style.background = 'White';
    }
    return error;
}


function validateMobilePhone(fld) {
    var error = "";
    var illegalChars = /[^0-9 ]/;
    var firstDigits=/^[69][0-9]+$/ ;
    var stripped = fld.value.replace(/[\(\)\.\-\ ]/g, '');
    var obj = document.getElementById('mobphone_error1');
    obj.style.display = 'none';
    obj = document.getElementById('mobphone_error2');
    obj.style.display = 'none';
    obj = document.getElementById('mobphone_error3');
    obj.style.display = 'none';

   if (fld.value == "") {
        error = "You didn't enter a phone number.\n";
        fld.style.background='#febcba';
	obj = document.getElementById('mobphone_error1');
	obj.style.display = 'inline';
    } else if (illegalChars.test(fld.value)) {
        error = "The phone number contains illegal characters.\n";
        fld.style.background='#febcba';
	obj = document.getElementById('mobphone_error2');
	obj.style.display = 'inline';
    } else if (!(stripped.length == 10)) {
        error = "The phone number is the wrong length. Make sure you included an area code.\n";
        fld.style.background='#febcba';
	obj = document.getElementById('mobphone_error3');
	obj.style.display = 'inline';
    } else if (!(stripped.match(firstDigits))) {
        error = "The phone number must start with 69";
        fld.style.background='#febcba';
	obj = document.getElementById('mobphone_error4');
	obj.style.display = 'inline';
    }else {
        fld.style.background = 'White';
    }
    return error;
}


function validateNumber(fld) {
   var error="";
   var illegalChars = /[^0-9 ]/;


    var obj = document.getElementById('nbr_error');
    obj.style.display = 'none';

    if(illegalChars.test(fld.value)){
       error ="Not a number";
       obj = document.getElementById('nbr_error');
       fld.style.background='#febcba';
       obj.style.display = 'table-row';}
    else {
        fld.style.background = 'White';
    }

    if(error!="")
        return false;
    else
        return true;
}


function validateFormOnLogin(theForm) {
    var valid= 0;

    valid += validUsername(theForm.un);
    valid += validPassword(theForm.pw);


  if (valid != 2) {
    return false;
  }

  return true;
}

function validUsername(fld) {

    var obj = document.getElementById('user_error');
    obj.style.display = 'none';

    if (fld.value == "") {
        valid=0;
        obj = document.getElementById('user_error');
        //fld.style.border='1px solid #febcba';
        obj.style.display = 'inline';}
    else {
        fld.style.background = 'White';
        valid=1;
    }
    return valid;
}
function validPassword(fld) {

    var obj = document.getElementById('pass_error');
    obj.style.display = 'none';

    if (fld.value == "") {
        valid=0;
        //fld.style.border='1px solid #febcba';
	obj = document.getElementById('pass_error');
	obj.style.display = 'inline';
    }else {
        fld.style.background = 'White';
        valid=1;
    }
   return valid;
}

function checkclick(check_name)
{
    var doc=document.forms["checkForm"];

        var count = 0;
        for (var i=0; i < doc.length ;i++){
                if (doc.elements[i].type=="checkbox" && doc.elements[i].checked)
                        count++
        }
        //document.checkForm.write(document.checkForm.elements[k].name==check_name);
        for (var k=0; k < doc.length ;k++){
                if (doc.elements[k].type=="checkbox" && count>4 && doc.elements[k].name==check_name){
                        doc.elements[k].checked= false
                        alert ("Μπορείτε να επιλέξετε μέχρι 4 προϊόντα για σύγκριση")
                        break
                }
        }

}

function checkCompare()
{
        var doc=document.forms["checkForm"];

        var count = 0;
        for (var i=0; i < doc.length ;i++){
                if (doc.elements[i].type=="checkbox" && doc.elements[i].checked)
                        count++
        }
        //document.checkForm.write(document.checkForm.elements[k].name==check_name);

        if (count==0){                
            alert ("Δεν έχετε επιλέξει προϊόντα προς σύγκριση.");
            return false;
        }
        return true;

}



      


function Checkboxes(MyForm){
    var doc=document.forms["checkForm"];
		var count = 0;
		for (var i=0; i < MyForm.elements.length ;i++){
			if (MyForm.elements[i].type=="checkbox" && MyForm.elements[i].checked)
				count++
		}

		for (var k=0; k < MyForm.elements.length ;k++){
			if (MyForm.elements[k].type=="checkbox" && count>4){
				MyForm.elements[k].checked= false
				alert ("Μπορείτε να επιλέξετε μέχρι 4 προϊόντα για σύγκριση")
				break
			}
		}
}

function deleteProduct(name){

   document.getElementById(name).style.textDecoration='line-through';
   document.getElementById(name).style.color='red';
   document.getElementById(name+"_delet").style.display='none';
   document.getElementById(name+"_recov").style.display='inline';
   document.getElementById(name+"_numItems").disabled=true;

   return true;

}

function undoDeleteProduct(name){

   document.getElementById(name).style.textDecoration='none';
   document.getElementById(name).style.color='blue';
   document.getElementById(name+"_delet").style.display='inline';
   document.getElementById(name+"_recov").style.display='none';
   document.getElementById(name+"_numItems").disabled=false;
   return true;

}


function check(thisvalue)
{
alert(thisvalue.options[thisvalue.selectedIndex].value)
}

function checkChanged2(){

    if (document.order.apostoli.selectedIndex==1){
        var obj = document.getElementById('shop');
        obj.style.display = 'inline';
        obj = document.getElementById('shopName');
        obj.style.display = 'inline';
    }else if(document.order.apostoli.selectedIndex==0){
        obj = document.getElementById('shop');
        obj.style.display = 'none';
        obj = document.getElementById('shopName');
        obj.style.display = 'none';
    }

}

function checkChanged(){

    //var id="card";
    if(document.order.pliromi.selectedIndex==0){
        document.getElementById("info").style.display='none';
        document.getElementById("cardholderName").style.display='none';
        document.getElementById("cardholderNameField").style.display='none';
        document.getElementById("cardholderPho").style.display='none';
        document.getElementById("cardholderPhoField").style.display='none';
        document.getElementById("creditCard").style.display='none';
        document.getElementById("creditCardOpt").style.display='none';
        document.getElementById("cardno").style.display='none';
        document.getElementById("cardnofield").style.display='none';
        document.getElementById("cvv").style.display='none';
        document.getElementById("cvvfld").style.display='none';
        document.getElementById("cvvfld").style.display='none';
        document.getElementById("expiredate").style.display='none';
        document.getElementById("expire").style.display='none';
        document.getElementById("space").style.display='none';
        var obj = document.getElementById('cardno_error1');
        obj.style.display = 'none';
        obj = document.getElementById('cardno_error2');
        obj.style.display = 'none';
        obj = document.getElementById('cardno_error3');
        obj.style.display = 'none';
        obj = document.getElementById('cvv_error1');
        obj.style.display = 'none';
        obj = document.getElementById('cvv_error2');
        obj.style.display = 'none';
        obj = document.getElementById('cvv_error3');
        obj.style.display = 'none';
        obj = document.getElementById('cardpho_error1');
        obj.style.display = 'none';
        obj = document.getElementById('cardpho_error2');
        obj.style.display = 'none';
        obj = document.getElementById('cardpho_error3');
        obj.style.display = 'none';
        obj = document.getElementById('cardname_error1');
        obj.style.display = 'none';
        obj = document.getElementById('cardname_error2');
        obj.style.display = 'none';


    }
    
    if(document.order.pliromi.selectedIndex==1){
        document.order.pliromi.options[1].selected=true;
        document.getElementById("info").style.display='table-row';
        document.getElementById("cardholderName").style.display='table-row';
        document.getElementById("cardholderNameField").style.display='table-row';
        document.getElementById("cardholderPho").style.display='table-row';
        document.getElementById("cardholderPhoField").style.display='table-row';
        document.getElementById("creditCard").style.display='table-row';
        document.getElementById("creditCardOpt").style.display='table-row';
        document.getElementById("cardno").style.display='table-row';
        document.getElementById("cardnofield").style.display='table-row';
        document.getElementById("cvv").style.display='table-row';
        document.getElementById("cvvfld").style.display='table-row';
        document.getElementById("expire").style.display='table-row';
        document.getElementById("expiredate").style.display='table-row';
        document.getElementById("space").style.display='table-row';




    }

        
	

}

function selectcard(cc)
{
	if (document.order.pliromi.selectedIndex==1)
	{
		document.order.cardtype.value=cc;
	}
}


function validateCardNumber(fld) {
    var error = "";
    var illegalChars = /[^0-9 ]/;
    var stripped = fld.value.replace(/[\(\)\.\-\ ]/g, '');
    var obj = document.getElementById('cardno_error1');
    obj.style.display = 'none';
    obj = document.getElementById('cardno_error2');
    obj.style.display = 'none';
    obj = document.getElementById('cardno_error3');
    obj.style.display = 'none';

   if (fld.value == "") {
        error = "You didn't enter a card number.\n";
        fld.style.background='#febcba';
	obj = document.getElementById('cardno_error1');
	obj.style.display = 'inline';
    } else if (illegalChars.test(fld.value)) {
        error = "The card number contains illegal characters.\n";
        fld.style.background='#febcba';
	obj = document.getElementById('cardno_error2');
	obj.style.display = 'inline';
    } else if (!(stripped.length == 16)) {
        error = "The card number is the wrong length.\n";
        fld.style.background='#febcba';
	obj = document.getElementById('cardno_error3');
	obj.style.display = 'inline';
    }else {
        fld.style.background = 'White';
    }
    return error;
}



function validateCvv(fld) {
    var error = "";
    var illegalChars = /[^0-9 ]/;
    var stripped = fld.value.replace(/[\(\)\.\-\ ]/g, '');
    var obj = document.getElementById('cvv_error1');
    obj.style.display = 'none';
    obj = document.getElementById('cvv_error2');
    obj.style.display = 'none';
    obj = document.getElementById('cvv_error3');
    obj.style.display = 'none';

   if (fld.value == "") {
        error = "You didn't enter a number.\n";
        fld.style.background='#febcba';
	obj = document.getElementById('cvv_error1');
	obj.style.display = 'inline';
    } else if (illegalChars.test(fld.value)) {
        error = "The number contains illegal characters.\n";
        fld.style.background='#febcba';
	obj = document.getElementById('cvv_error2');
	obj.style.display = 'inline';
    } else if (!(stripped.length == 3)) {
        error = "The card number is the wrong length.\n";
        fld.style.background='#febcba';
	obj = document.getElementById('cvv_error3');
	obj.style.display = 'inline';
    }else {
        fld.style.background = 'White';
    }
    return error;
}



function validateCardHolderPhone(fld) {
    var error = "";
    var illegalChars = /[^0-9 ]/;
    var stripped = fld.value.replace(/[\(\)\.\-\ ]/g, '');
    var obj = document.getElementById('cardpho_error1');
    obj.style.display = 'none';
    obj = document.getElementById('cardpho_error2');
    obj.style.display = 'none';
    obj = document.getElementById('cardpho_error3');
    obj.style.display = 'none';

   if (fld.value == "") {
        error = "You didn't enter a phone number.\n";
        fld.style.background='#febcba';
	obj = document.getElementById('cardpho_error1');
	obj.style.display = 'inline';
    } else if (illegalChars.test(fld.value)) {
        error = "The phone number contains illegal characters.\n";
        fld.style.background='#febcba';
	obj = document.getElementById('cardpho_error2');
	obj.style.display = 'inline';
    } else if (fld.value == "0") {
        fld.style.background = 'White';
    } else if (!(stripped.length == 10)) {
        error = "The phone number is the wrong length.\n";
        fld.style.background='#febcba';
	obj = document.getElementById('cardpho_error3');
	obj.style.display = 'inline';
    }else {
        fld.style.background = 'White';
    }
    return error;
}

function validateCardHolderName(fld) {
   var error="";
    var illegalChars = /[^a-zA-Zα-ωΑ-ΩάϊέύίόήώΆΈΎΊΌΉΏ]/;

    var obj = document.getElementById('cardname_error1');
    obj.style.display = 'none';
    obj = document.getElementById('cardname_error2');
    obj.style.display = 'none';

    if (fld.value == "") {
        error = "You didn't enter a name.\n";
        obj = document.getElementById('cardname_error1');
        fld.style.background='#febcba';
        obj.style.display = 'inline';}
    else if(illegalChars.test(fld.value)){
       error ="Your name has special characters.These are not allowed.";
       obj = document.getElementById('cardname_error2');
       fld.style.background='#febcba';
       obj.style.display = 'inline';}
    else {
        fld.style.background = 'White';
    }
    return error;
}

function checkChangedCat(){

     obj = document.getElementById('subcateg_'+document.getElementById('category').selectedIndex);
     obj.style.display = 'inline';
     for(var i=0;i<document.getElementById('category').options.length;i++){
         if(i!=document.getElementById('category').selectedIndex){
            obj = document.getElementById('subcateg_'+i);
            obj.style.display = 'none';
         }
     }
     if(obj.options.length>0) obj.options[0].selected = 'selected';
}

function checkChangedCateg(){    
    
     obj = document.getElementById('subcateg_'+document.checkInsertForm.category.selectedIndex);
     obj.style.display = 'inline';
     for(var i=0;i<document.checkInsertForm.category.options.length;i++){
         if(i!=document.checkInsertForm.category.selectedIndex){
            obj = document.getElementById('subcateg_'+i);
            obj.style.display = 'none';
         }
     }
     if(obj.options.length>0) obj.options[0].selected = 'selected';
}

function onloadSetOptions(){


     obj = document.checkInsertForm.category.options[0];
     obj.selected = 'selected';    
     obj = document.getElementById('check0_options');
     obj.style.display = 'inline';
     //for (var k=0; k < doc.length ;k++){
         //doc.elements[k].checked= false;
    //}
}

function checkChangedSubcateg(subcateg_size,charact_size){

   
   var j=document.checkInsertForm.category.selectedIndex;
   var selindx=document.getElementById('subcateg_'+j).selectedIndex;
   var k = document.getElementById('subcateg_'+j).options[selindx].id;   

   for(var catindx=0; catindx<document.checkInsertForm.category.length; catindx++){
       var subcat = document.getElementById('subcateg_'+catindx);
       for(var subcatindx = 0; subcatindx<subcat.length; subcatindx++ ){
           for(var m=0;m<charact_size;m++){
               var charact = document.getElementById('characteristic_'+subcat.options[subcatindx].id+'_'+m);
               if(charact==null){
                   break;
               }else{
                    charact.style.display = 'none';
               }
           }
       }
   }

   for(var l=0;l<charact_size;l++){
        if(document.getElementById('characteristic_'+k+'_'+l)!=null){
            obj = document.getElementById('characteristic_'+k+'_'+l);
            obj.style.display = 'table-row';
        }
    }

}


function onloadSetOption(){

     obj = document.checkInsertForm.category.options[0];
     obj.selected = 'selected';
     obj = document.getElementById('subcateg_'+document.checkInsertForm.category.options[0].id).options[0];
     obj.selected = 'selected';
     checkChangedSubcategory();
}

function checkChangedCategory(){

     indx=document.checkInsertForm.category.selectedIndex;
     obj = document.getElementById('subcateg_'+document.checkInsertForm.category.options[indx].id);
     obj.style.display = 'inline';
     for(var i=0;i<document.checkInsertForm.category.options.length;i++){
         if(i!=document.checkInsertForm.category.selectedIndex){
            obj = document.getElementById('subcateg_'+document.checkInsertForm.category.options[i].id);
            obj.style.display = 'none';
         }
     }
     if(obj.options.length>0) obj.options[0].selected = 'selected';
     
}

function checkChangedSubcategory(){

   var j=document.checkInsertForm.category.selectedIndex;
  
   var selindx=document.getElementById('subcateg_'+document.checkInsertForm.category.options[j].id).selectedIndex;
   
   // hide all
   for(var catindx=0; catindx<document.checkInsertForm.category.length; catindx++){
       var subcat = document.getElementById('subcateg_'+document.checkInsertForm.category.options[catindx].id);
       for(var subcatindx = 0; subcatindx<subcat.length; subcatindx++ ){
               //if (catindx==6 && subcatindx==0){document.write(subcat.options[subcatindx].id);}
               var charact = document.getElementById('characteristic_'+subcat.options[subcatindx].id);
               if(charact==null){
                   break;
               }else{
                    charact.style.display = 'none';
               }

       }
   }
   

   if(selindx<0){
       hidePlusButton=document.getElementById('addCharact');
        hidePlusButton.style.display='none';
        hideMinusButton=document.getElementById('delCharact');
        hideMinusButton.style.display='none';
        return;
    }
    var k = document.getElementById('subcateg_'+document.checkInsertForm.category.options[j].id).options[selindx].id;
    if(document.getElementById('characteristic_'+k)!=null){
        obj = document.getElementById('characteristic_'+k);
        obj.style.display = 'inline';
    }
    showPlusButton=document.getElementById('addCharact');
    showPlusButton.style.display='inline';
    showMinusButton=document.getElementById('delCharact');
    showMinusButton.style.display='inline';

    


}

function addCategory(){
    var categ=prompt("Όνομα νέας κατηγορίας","");
    categ = categ.toString();
    obj = document.checkInsertForm.category;
    var length= obj.options.length;
    if (length==0){
       newid=1;
    }else{
        newid=document.checkInsertForm.category.options[length-1].id;
        newid=parseInt(newid)+1;
    }
    obj.options[obj.options.length]=new Option(categ,newid+"_"+categ , false, true);
    obj.options[obj.options.length-1].setAttribute("onclick","javascript:checkChangedCategory();javascript:checkChangedSubcategory()");
    obj.options[obj.options.length-1].setAttribute("id",newid);

    obj=document.getElementById('Subcategory_fieldset');
    var se = document.createElement("select");
   
    se.name = "subcateg"+newid;
    se.id="subcateg_"+newid;
    se.style.width='200px';
    se.size="20";

    obj=document.getElementById('Subcategory_fieldset');
    obj.appendChild(se);
    checkChangedCategory();
    checkChangedSubcategory();

    

}

function addSubcategory(){
    var subcateg=prompt("Όνομα νέας υποκατηγορίας","");
    subcateg=subcateg.toString();
    indx=document.checkInsertForm.category.selectedIndex;
    obj = document.getElementById('subcateg_'+document.checkInsertForm.category.options[indx].id);
    subcatid=document.checkInsertForm.category.options[indx].id;
    var length= obj.options.length;
    if (length==0){        
        newid=1;
    }else{
        newid=obj.options[length-1].id;
        var temp=new Array();
        temp=newid.split('_');
        prev=temp[2];
        if(temp[2]==null){
            newid=newid+1;
        }else{
        newid=parseInt(prev)+1;
        }
    }
    obj.options[obj.options.length]=new Option(subcateg,'new'+subcatid+newid+"_"+subcateg, true, false);
    obj.options[obj.options.length-1].setAttribute("onclick","javascript:checkChangedSubcategory()");
    obj.options[obj.options.length-1].id='new_'+subcatid +'_'+newid;

    obj.options[obj.options.length-1].selected='selected';
    obj=document.getElementById('Characteristics_fieldset');
    se = document.createElement("select");

    se.name = "characteristicnew"+subcatid+newid;
    se.id="characteristic_new_"+subcatid +'_'+newid;
    se.style.width='200px';
    se.size="20";

    //for(i=1;i<=length;i++){
      //  obj = document.getElementById('characteristic_'+i);
        //obj.style.display = 'none';
     //}
    obj=document.getElementById('Characteristics_fieldset');
    obj.appendChild(se);

    
    checkChangedCategory();
    checkChangedSubcategory();

    
}

function addCharacteristic(){
    var characteristic=prompt("Όνομα νέου χαρακτηριστικού","");
    characteristic=characteristic.toString();
    var j=document.checkInsertForm.category.selectedIndex;
    var selindx=document.getElementById('subcateg_'+document.checkInsertForm.category.options[j].id).selectedIndex;
    
    var k = document.getElementById('subcateg_'+document.checkInsertForm.category.options[j].id).options[selindx].id;
    
    if(document.getElementById('characteristic_'+k)!=null){
        obj = document.getElementById('characteristic_'+k);
    }
    //document.write('characteristic_'+k);
    //var length= obj.options.length;
    obj.options[obj.options.length]=new Option(characteristic, 'characteristic_'+k+"_"+0+"_"+characteristic, true, false);
    
    

}



function delCategory(){

    var j=document.checkInsertForm.category.selectedIndex;
    subcatobj=document.getElementById('subcateg_'+document.checkInsertForm.category.options[j].id);
    if(subcatobj!=null){
        charfieldObj=document.getElementById('Characteristics_fieldset');
        for(var i=0;i<subcatobj.length;i++){
            subcatOption=document.getElementById('subcateg_'+document.checkInsertForm.category.options[j].id).options[i];
            var k = subcatOption.id;
            charobj=document.getElementById('characteristic_'+k);
            if(charobj!=null)
            charfieldObj.removeChild(charobj);
        }
        subcatfieldObj=document.getElementById('Subcategory_fieldset');
        subcatfieldObj.removeChild(subcatobj);//delete subcategories
    }
    document.checkInsertForm.category.options[j]=null; //delete categ
    document.checkInsertForm.category.options[0].selected='selected';
    checkChangedCategory();
    checkChangedSubcategory();
}

function delSubcategory(){
     
    var j=document.checkInsertForm.category.selectedIndex;
    var indx=document.getElementById('subcateg_'+document.checkInsertForm.category.options[j].id).selectedIndex;
    subobj=document.getElementById('subcateg_'+document.checkInsertForm.category.options[j].id).options[indx];
    var k = subobj.id;
    obj=document.getElementById('Characteristics_fieldset');
    charobj=document.getElementById('characteristic_'+k);
    if(charobj!=null)
    obj.removeChild(charobj);
    document.getElementById('subcateg_'+document.checkInsertForm.category.options[j].id).options[indx]=null;
    document.getElementById('subcateg_'+document.checkInsertForm.category.options[j].id).options[0].selected='selected';
    checkChangedCategory();
    checkChangedSubcategory();

}


function delCharacteristic(){
    
    var j=document.checkInsertForm.category.selectedIndex;
    var indx=document.getElementById('subcateg_'+document.checkInsertForm.category.options[j].id).selectedIndex;
    subobj=document.getElementById('subcateg_'+document.checkInsertForm.category.options[j].id).options[indx];
    var k = subobj.id;
    charobj=document.getElementById('characteristic_'+k);
    charobj.options[charobj.selectedIndex]=null;
    checkChangedCategory();
    checkChangedSubcategory();
    
    
}



function sendAllAttributes(){

    document.checkInsertForm.category.multiple='multiple';
    for(var i=0;i<document.checkInsertForm.category.length;i++){
        document.checkInsertForm.category.options[i].selected='selected';
        subcatobj=document.getElementById('subcateg_'+document.checkInsertForm.category.options[i].id);
        subcatobj.multiple='multiple';
        for(var j=0;j<subcatobj.length;j++){
            subcatobj.options[j].selected='selected';
            var k = subcatobj.options[j].id;
            charobj=document.getElementById('characteristic_'+k);
            charobj.multiple='multiple';
            for(var m=0;m<charobj.length;m++){
                charobj.options[m].selected='selected';
            }
        }
    }
}

function confirmChangeOrdersOption(){
    var doc=document.forms["changeOrders"];

    var count = 0;
    for (var i=0; i < doc.length ;i++){
            if (doc.elements[i].type=="checkbox" && doc.elements[i].checked)
                    count++
    }

    if (count==0){
        alert ("Δεν έχετε επιλέξει παραγγελίες για ενημέρωση.");
        return false;
    }

    return true;
}

function confirmOption(){
    var doc=document.forms["myCarts"];

    var count = 0;
    for (var i=0; i < doc.length ;i++){
            if (doc.elements[i].type=="checkbox" && doc.elements[i].checked)
                    count++
    }

    if (count==0){
        alert ("Δεν έχετε επιλέξει καλάθια αγορών προς διαγραφή.");
        return false;
    }

    var answer=confirm('Είστε σίγουρος ότι θέλετε να διαγράψετε τα επιλεγμένα καλάθια αγορών;');
    return answer;
}

function confirmCancelOption(){
    var doc=document.forms["order"];
        
    var answer=confirm('Είστε σίγουρος ότι θέλετε να ακυρώσετε την παραγγελία;');
    return answer;    
}


function checkChangedInventoryCat(){

     indx=document.getElementById('category').selectedIndex;
     
     if(indx==0){
         obj = document.getElementById('subcateg_'+document.getElementById("category").options[indx+1].id);
         for(var i=1;i<document.getElementById('category').options.length;i++){
            obj = document.getElementById('subcateg_'+document.getElementById('category').options[i].id);
            obj.style.display = 'none';
         }
          obj = document.getElementById('emptyScroll');
          obj.style.display = 'inline';
          return;
     }
         
     obj = document.getElementById('emptyScroll');
     obj.style.display = 'none';
     obj = document.getElementById('subcateg_'+document.getElementById("category").options[indx].id);     
     obj.style.display = 'inline';
     
     for(i=1;i<document.getElementById('category').options.length;i++){
         if(i!=indx){            
            obj = document.getElementById('subcateg_'+document.getElementById('category').options[i].id);
            obj.style.display = 'none';            
         }
     }
     if(obj.options.length>0) obj.options[0].selected = 'selected';
}

function confirmLoad(){
    return confirm('Αν συνεχίσετε με τη φόρτωση του καλαθιού, το τρέχον καλάθι σας θα χαθεί.Αν θέλετε μπορείτε να ακυρώσετε τη φόρτωση και να αποθηκεύσετε πρώτα το τρέχον καλάθι σας.Είστε σίγουρος ότι θέλετε να συνεχίσετε με τη φόρτωση;');
    
}

function addIncompatibleProduct(){
    
    var ob=document.getElementById('products');
    obj = document.getElementById('incompatible');
    for (var i = 0; i < ob.options.length; i++){
        if (ob.options[ i ].selected){
           var sn=document.getElementById('products').options[i].id;                     
           obj.options[obj.options.length]=new Option(sn, document.getElementById('products').options[i].value , false, false);
           obj.options[obj.options.length-1].label=sn;
           obj.options[obj.options.length-1].style.color='blue';
           ob.options[i]=null;
           i=i-1;
       }
    }    
}

function delIncompatibleProduct(){

    var ob=document.getElementById('incompatible');
    obj = document.getElementById('products');
    for (var i = 0; i < ob.options.length; i++){
        if (ob.options[ i ].selected){
           var sn=document.getElementById('incompatible').options[i].label;
           obj.options[obj.options.length]=new Option(sn, sn, false, false);           
           obj.options[obj.options.length-1].style.color='blue';
           ob.options[i]=null;
           i=i-1;
       }
    }
}

function addMaxPerformanceProduct(){
    var ob=document.getElementById('maxProducts');
    obj = document.getElementById('maxPerform');
    for (var i = 0; i < ob.options.length; i++){
        if (ob.options[ i ].selected){
           var sn=document.getElementById('maxProducts').options[i].id;
           sn = sn.split("_");
           obj.options[obj.options.length]=new Option(sn[1], document.getElementById('maxProducts').options[i].value, false, false);
           obj.options[obj.options.length-1].label=sn;
           obj.options[obj.options.length-1].style.color='blue';
           ob.options[i]=null;
           i=i-1;
       }
    }

}

function delMaxPerformanceProduct(){
    var ob=document.getElementById('maxPerform');
    obj = document.getElementById('maxProducts');
    for (var i = 0; i < ob.options.length; i++){
        if (ob.options[ i ].selected){
           var sn=document.getElementById('maxPerform').options[i].label;
           obj.options[obj.options.length]=new Option(sn, sn, false, false);
           obj.options[obj.options.length-1].style.color='blue';
           ob.options[i]=null;
           i=i-1;
       }
    }

}

function sendAttributes(){

    var ob=document.getElementById('maxPerform');
    for(var i=0;i<ob.length;i++){
        ob.options[i].selected='selected';
    }
    var obj=document.getElementById('incompatible');
    for(i=0;i<obj.length;i++){
        obj.options[i].selected='selected';
    }

}

function confirmDelete(sn){

    var answer=confirm('Είστε σίγουρος ότι θέλετε να διαγράψετε αυτό το προϊόν;');
    if(answer){
        location.href='Controller?action=showConfirmDeleteProductPage&SN='+sn;
    }
    if(!answer){
        document.write(answer);
        location.href='Controller?action=showDeleteProductPage&sn='+sn;
    }

}


function checkEmailFields(){

    var valid=validateEmail(document.contact.email);
    if (valid!=""){
        return false;
    }else{
      var obj=document.getElementById("subject");
      if(obj.value==""){
            var answer=confirm('Είστε σίγουρος ότι θέλετε να στείλετε e-mail χωρίς θέμα;');
            if(answer){
                obj=document.getElementById("body");
                if(obj.value==""){
                    answer=confirm('Είστε σίγουρος ότι θέλετε να στείλετε e-mail χωρίς κυρίως κείμενο;');
                    if(answer){
                        if(obj.value==""){
                            alert('Δεν μπορείτε να στείλετε e-mail χωρίς θέμα και χωρίς κυρίως κείμενο');
                        }
                        return false;
                    }
                    if(!answer){
                        return false;
                    }
                }
            }
            if(!answer){
                return false;
            }
      }else{
          obj=document.getElementById("body");
          if(obj.value==""){
                answer=confirm('Είστε σίγουρος ότι θέλετε να στείλετε e-mail χωρίς κυρίως κείμενο;');
                if(answer){                                
                    return true;
                }
                if(!answer){
                    return false;
                }  
        }
      }
    }
    return true;

}

function checkForgetEmail(){
    var valid=validateEmail(document.forgotPass.email); 
    if (valid!=""){
        return false;
    }
    return true;
}