/*!
* Start Bootstrap - Heroic Features v5.0.5 (https://startbootstrap.com/template/heroic-features)
* Copyright 2013-2022 Start Bootstrap
* Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-heroic-features/blob/master/LICENSE)
*/
// This file is intentionally blank
// Use this file to add JavaScript to your project

function product_update(){
	document.form1.action="/product/update";
	document.form1.submit();
} // product_update() end

function product_delete(){
	if(confirm("영구히 삭제됩니다\n진행할까요?")){
		document.form1.action="/product/delete";
		document.form1.submit();
	}// if end
} // product_delete() end