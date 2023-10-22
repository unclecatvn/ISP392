const addAnswerButton = document.getElementById('addAnswerButton');
const answerContainer = document.getElementById('answerContainer');
const questionTypeSelect = document.getElementById('questionType');
const multipleChoiceOptionsDiv = document.getElementById('multipleChoiceOptions');
const deleteAnswerButton = document.getElementById('deleteAnswerButton');
const answerCountInput = document.getElementById('answerCount');
const checkboxCountInput = document.getElementById('checkboxCount');
//const messAnswerDiv = document.getElementById('messAnswer');

// Lấy phần tử textarea "Explain" có class "explain"
const explainTextarea = document.querySelector('.explain');
const addQuestionButton = document.getElementById('addQuestionButton');
// Số lượng input answers đã được tạo
let answerCount = 0;
let checkboxCount = 0;

// Sự kiện khi nút "Delete" được nhấp
deleteAnswerButton.addEventListener('click', () => {
    // Xóa toàn bộ đáp án
    answerContainer.innerHTML = '';
    answerCount = 0;
    checkboxCount = 0;
    checkboxCountInput.value = checkboxCount;
    answerCountInput.value = answerCount;
    explainTextarea.style.display = 'none';
//    messAnswerDiv.style.display = 'none';

    addQuestionButton.disabled = true;
    addQuestionButton.style.backgroundColor = "gray";
    document.getElementById("messAnswer").innerHTML = "Choose question type";
});

//Thông báo Answer nhập thiếu
//function showMessage(message) {
//    // Thay đổi nội dung của thẻ div
//    messAnswerDiv.innerHTML = `<b>${message}</b>`;
//    // Hiển thị thẻ div
//    messAnswerDiv.style.display = 'block';
//}
addQuestionButton.disabled = true;
addQuestionButton.style.backgroundColor = "gray";
document.getElementById("messAnswer").innerHTML = "Choose question type";

// Xử lý sự kiện khi nút "Insert" được nhấp
addAnswerButton.addEventListener('click', (event) => {
    event.preventDefault(); // Ngăn chặn hành vi mặc định của nút (tải lại trang)
    if (questionTypeSelect.value !== "Select insert question") {
        // Lấy giá trị của select
        const selectedOption = questionTypeSelect.value;

        // Tạo một div container cho cặp label, checkbox và textarea
        const answerDiv = document.createElement('div');
        answerDiv.classList.add('answer-group');

        // Tạo một label cho input và thêm class "form-control"
        const newAnswerLabel = document.createElement('label');
        newAnswerLabel.textContent = `${String.fromCharCode(65 + answerCount)}: `;
        newAnswerLabel.classList.add('form-control');
        newAnswerLabel.classList.add('labelQuestion');

        // Tạo một checkbox cho input
        const newAnswerCheckBox = document.createElement('input');
        newAnswerCheckBox.type = 'checkbox';
        newAnswerCheckBox.classList.add('form-check-input');
        newAnswerCheckBox.classList.add('checkboxQuestion');
        newAnswerCheckBox.style = 'margin: 0;height: auto;width: 25px;';
        newAnswerCheckBox.name = `answerCheckBox${answerCount + 1}`; // Vanhle -->
        newAnswerCheckBox.id = `answerCheckBox${answerCount + 1}`;

        // Tạo một textarea mới
        const newAnswerInput = document.createElement('textarea');
        newAnswerInput.classList.add('inputQuestion');
        newAnswerInput.classList.add('form-control');
        newAnswerInput.placeholder = 'Enter answer';
        newAnswerInput.name = `answer${answerCount + 1}`;
        newAnswerInput.id = `${answerCount + 1}`;
        console.log(newAnswerInput.id);

        // Clone select "multipleChoiceOptions" chỉ khi Option 2 (Multiple Choice) được chọn
        if (selectedOption === '2') {
            const selectClone = multipleChoiceOptionsDiv.cloneNode(true);
            selectClone.style.display = 'block';
            selectClone.style = 'width: 100px;';
            newAnswerCheckBox.style = 'display:none;';
            answerDiv.appendChild(selectClone); // Thêm select clone vào div container
        }

        // Thêm label và checkbox vào div container
        answerDiv.appendChild(newAnswerLabel);
        answerDiv.appendChild(newAnswerCheckBox);


        // Thêm div container vào vùng chứa
        answerContainer.appendChild(answerDiv);
        answerContainer.appendChild(newAnswerInput);

        // Tăng số lượng input answers đã được tạo
        answerCount++;

        // Cập nhật giá trị cho input "answerCount"
        answerCountInput.value = answerCount; //-->

        // Lấy danh sách tất cả các checkbox
        const checkboxes = document.querySelectorAll('.checkboxQuestion');

        if (selectedOption === "True") {
            const addQuestionButton = document.getElementById('addQuestionButton');
            if (newAnswerInput.id < 3) {
                if (answerCount < 3) {
                    addQuestionButton.disabled = true;
                    addQuestionButton.style.backgroundColor = "gray";
                    document.getElementById("messAnswer").innerHTML = "Must be at least 3 answer";
                } else {
                    addQuestionButton.disabled = false;
                    addQuestionButton.style.backgroundColor = "#F26F21";
                    document.getElementById("messAnswer").innerHTML = "";
                }
            }
        } else if (selectedOption === "False") {

//            if (newAnswerInput.id < 2) {

            var checkbox1 = document.getElementById("answerCheckBox1");
            if (answerCount < 2) {
                checkbox1.disabled = true;
                addQuestionButton.disabled = true;
                addQuestionButton.style.backgroundColor = "gray";
                document.getElementById("messAnswer").innerHTML = "Must be at least 2 answer";
            } else {
                checkbox1.disabled = false;
                addQuestionButton.disabled = true;
                addQuestionButton.style.backgroundColor = "gray";
                document.getElementById("messAnswer").innerHTML = "";
            }
//            }

        } else if (questionTypeSelect.value === "Select insert question") {
            addQuestionButton.disabled = true;
            addQuestionButton.style.backgroundColor = "#gray";
            document.getElementById("messAnswer").innerHTML = "Choose question type";
        }

        // Sự kiện khi một checkbox được chọn
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', (event) => {
                // Duyệt qua tất cả các checkbox và hủy chọn chúng (nếu không phải là checkbox hiện đang được chọn)
                if (questionTypeSelect.value === "False") {
                    checkboxes.forEach(otherCheckbox => {

                        const selectedCheckboxCount = document.querySelectorAll('.checkboxQuestion:checked').length;
                        checkboxCount = selectedCheckboxCount;
                        checkboxCountInput.value = checkboxCount;
                        if (selectedCheckboxCount < 1) {

                            addQuestionButton.disabled = true;
                            addQuestionButton.style.backgroundColor = "gray";
                            document.getElementById("messAnswer").innerHTML = "Must be 1 correct answer and 2 answer";
                        } else {

                            addQuestionButton.disabled = false;
                            addQuestionButton.style.backgroundColor = "#F26F21";
                            document.getElementById("messAnswer").innerHTML = "";
                        }
                        if (otherCheckbox !== checkbox) {
                            otherCheckbox.checked = false;
                        }

                    });
//                    // Kiểm tra trạng thái của checkbox hiện tại
//                    if (checkbox.checked) {
//                        // Nếu checkbox được chọn, hiển thị textarea "Explain"
//                        explainTextarea.style.display = 'block';
//                    } else {
//                        // Nếu checkbox không được chọn, ẩn textarea "Explain"
//                        explainTextarea.style.display = 'none';
//                    }
                } else {
                    // Duyệt qua tất cả các checkbox và không cho người dùng chọn quá số lượng answerCount
                    checkboxes.forEach(checkbox => {
                        // Lấy số lượng checkbox đã được chọn
                        const selectedCheckboxCount = document.querySelectorAll('.checkboxQuestion:checked').length;
                        checkboxCount = selectedCheckboxCount;
                        checkboxCountInput.value = checkboxCount;
                        console.log(selectedCheckboxCount);
                        // Nếu số lượng checkbox đã được chọn lớn hơn hoặc bằng số lượng answerCount đang có, hãy hủy chọn checkbox hiện tại
                        if (selectedCheckboxCount >= answerCount) {
                            checkbox.checked = false;
                        }
                        if (selectedCheckboxCount < 2) {
                            document.getElementById("messAnswer").innerHTML = "Must be at least 2 correct answer";
                            addQuestionButton.disabled = true;
                            addQuestionButton.style.backgroundColor = "gray";
                        } else {
                            document.getElementById("messAnswer").innerHTML = "";
                            addQuestionButton.disabled = false;
                            addQuestionButton.style.backgroundColor = "#F26F21";
                        }
                    });

                }
                explainTextarea.style.display = 'block';
            });
        });
    }
});

// Sự kiện khi thẻ select "questionTypeSelect" được thay đổi
questionTypeSelect.addEventListener('change', () => {
    // Lấy giá trị của select
//    const selectedOption = questionTypeSelect.value;
    const checkboxCountInput = document.getElementById('checkboxCount');
    checkboxCountInput.value = 0;
    const addQuestionButton = document.getElementById('addQuestionButton');
    addQuestionButton.disabled = true;
    addQuestionButton.style.backgroundColor = "gray";
    if (questionTypeSelect.value === "True") {
        document.getElementById("messAnswer").innerHTML = "Must be at least 3 answer";
    } else {
        document.getElementById("messAnswer").innerHTML = "Must be at least 2 answer";
    }

    // Nếu người dùng chọn loại câu hỏi là Multiple Choice, hãy bỏ hết toàn bộ checkbox đã chọn trước đó
    const checkboxes = document.querySelectorAll('.checkboxQuestion');

    checkboxes.forEach(checkbox => {
        checkbox.checked = false;
    });

    // Ẩn textarea "Explain"
    explainTextarea.style.display = 'none';
});

document.addEventListener('DOMContentLoaded', function () {
    const showQuestionTitles = document.querySelectorAll('.showQuestionTitle');

    let answerCount = 0;
    const answerCountInput = document.getElementById('answerCount');
    answerCountInput.value = answerCount; // vANhle

    let checkboxCount = 0;
    const checkboxCountInput = document.getElementById('checkboxCount');
    checkboxCountInput.value = checkboxCount;
    showQuestionTitles.forEach(function (title) {
        const actionQuestion = title.querySelector('.actionQuestion');

        title.addEventListener('click', function (event) {
            // Kiểm tra nếu sự kiện click xảy ra trên phần tử actionQuestion
            if (event.target === actionQuestion || actionQuestion.contains(event.target)) {
                // Nếu click xảy ra trên actionQuestion, ngăn chặn sự kiện lan truyền lên cha
                event.stopPropagation();
            } else {
                const subMenu = title.nextElementSibling;

                if (subMenu.style.display === 'none' || subMenu.style.display === '') {
                    subMenu.style.display = 'block';
                } else {
                    subMenu.style.display = 'none';
                }
            }
        });
    });
});



