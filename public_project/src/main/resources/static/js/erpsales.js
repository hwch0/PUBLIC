

//모달창
const Modal = document.getElementById('erpModal');

console.log(Modal);

const paymFideBtn = $('#paymCodeFide');

paymFideBtn.on('click', function() {
    Modal.classList.add('on'); 
});

$(window).on('click', function(event) {
    if (event.target === Modal) {
        Modal.classList.remove('on'); 
    }
});

$('.close').on('click', function(e){
	 Modal.classList.remove('on'); 
});
