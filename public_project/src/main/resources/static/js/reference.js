const listSeat = document.querySelectorAll('.seat_grp ul li');
const onSeat = document.querySelectorAll('.seat_grp ul li.on');
const modal = document.getElementById('modal');
const listChat = document.querySelectorAll('.btn_grp ul li');

listSeat.forEach((li, index) => {
    const em = document.createElement('em');
    em.textContent = index + 1; 
    li.insertBefore(em, li.querySelector('a')); 
});

onSeat.forEach((li) => {
    li.addEventListener('click', function() {
        modal.style.display = 'block';
    });
});


window.addEventListener('click', (event) => {
    if (event.target === modal) {
        modal.style.display = 'none';
    }
});


function alert(){
	$('.wrap_cont').addClass("lft");
	$(".wrap_alert").addClass("on");
}

function chat(){
	$('.wrap_cont').addClass("lft");
	$(".wrap_chat").addClass("on");
}
/*document.addEventListener("DOMContentLoaded", function() {
    const listSeat = document.querySelectorAll(".seat_grp ul li");
    const wrapCont = document.querySelector(".wrap_cont");
    const wrapChat = document.querySelector(".wrap_chat");
    const wrapAlert = document.querySelector(".wrap_alert");
    const modal = document.getElementById('modal');

    listChat.forEach((li) => {
        li.addEventListener("click", function() {
            
            modal.classList.add("on");
            wrapCont.classList.add("lft");
            wrapChat.classList.add("on");
            wrapAlert.classList.add("on");
        });
    });
});*/

