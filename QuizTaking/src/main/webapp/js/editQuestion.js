const addAnswerButtonEdit = document.getElementById('addAnswerButtonEdit');
const answerContainerEdit = document.getElementById('answerContainerEdit');
const questionTypeEditSelect = document.getElementById('questionTypeEdit');
const multipleChoiceOptionsEditsDiv = document.getElementById('multipleChoiceOptionsEdits');
const deleteAnswerButtonEdit = document.getElementById('deleteAnswerButtonEdit');
const answerCountEditInput = document.getElementById('answerCountEdit');
const checkboxCountEditInput = document.getElementById('checkboxCountEdit');
//const messAnswerDiv = document.getElementById('messAnswer');

// Lấy phần tử textarea "Explain" có class "explain"
const explainTextareaEdit = document.querySelector('.explainEdit');
const addQuestionButtonEdit = document.getElementById('addQuestionButtonEdit');
// Số lượng input answers đã được tạo
let answerCountEdit = 0;
let checkboxCountEdit = 0;

// Sự kiện khi nút "Delete" được nhấp
deleteAnswerButtonEdit.addEventListener('click', () => {
    // Xóa toàn bộ đáp án
    answerContainerEdit.innerHTML = '';
    answerCountEdit = 0;
    checkboxCountEdit = 0;
    checkboxCountEditInput.value = checkboxCountEdit;
    answerCountEditInput.value = answerCountEdit;
    explainTextareaEdit.style.display = 'none';
//    messAnswerDiv.style.display = 'none';

    addQuestionButtonEdit.disabled = true;
    addQuestionButtonEdit.style.backgroundColor = "gray";
    document.getElementById("messAnswer").innerHTML = "Choose question type";
});

//Thông báo Answer nhập thiếu
//function showMessage(message) {
//    // Thay đổi nội dung của thẻ div
//    messAnswerDiv.innerHTML = `<b>${message}</b>`;
//    // Hiển thị thẻ div
//    messAnswerDiv.style.display = 'block';
//}
addQuestionButtonEdit.disabled = true;
addQuestionButtonEdit.style.backgroundColor = "gray";
document.getElementById("messAnswer").innerHTML = "Choose question type";

// Xử lý sự kiện khi nút "Insert" được nhấp
addAnswerButtonEdit.addEventListener('click', (event) => {
    event.preventDefault(); // Ngăn chặn hành vi mặc định của nút (tải lại trang)
    if (questionTypeEditSelect.value !== "Select insert question") {
        // Lấy giá trị của select
        const selectedOption = questionTypeEditSelect.value;

        // Tạo một div container cho cặp label, checkbox và textarea
        const answerDiv = document.createElement('div');
        answerDiv.classList.add('answer-group');

        // Tạo một label cho input và thêm class "form-control"
        const newAnswerLabel = document.createElement('label');
        newAnswerLabel.textContent = `${String.fromCharCode(65 + answerCountEdit)}: `;
        newAnswerLabel.classList.add('form-control');
        newAnswerLabel.classList.add('labelQuestion');

        // Tạo một checkbox cho input
        const newAnswerCheckBox = document.createElement('input');
        newAnswerCheckBox.type = 'checkbox';
        newAnswerCheckBox.classList.add('form-check-input');
        newAnswerCheckBox.classList.add('checkboxQuestion');
        newAnswerCheckBox.style = 'margin: 0;height: auto;width: 25px;';
        newAnswerCheckBox.name = `answerCheckBox${answerCountEdit + 1}`; // Vanhle -->
        newAnswerCheckBox.id = `answerCheckBox${answerCountEdit + 1}`;

        // Tạo một textarea mới
        const newAnswerInput = document.createElement('textarea');
        newAnswerInput.classList.add('inputQuestion');
        newAnswerInput.classList.add('form-control');
        newAnswerInput.placeholder = 'Enter answer';
        newAnswerInput.name = `answer${answerCountEdit + 1}`;
        newAnswerInput.id = `${answerCountEdit + 1}`;
        console.log(newAnswerInput.id);

        // Clone select "multipleChoiceOptionsEdits" chỉ khi Option 2 (Multiple Choice) được chọn
        if (selectedOption === '2') {
            const selectClone = multipleChoiceOptionsEditsDiv.cloneNode(true);
            selectClone.style.display = 'block';
            selectClone.style = 'width: 100px;';
            newAnswerCheckBox.style = 'display:none;';
            answerDiv.appendChild(selectClone); // Thêm select clone vào div container
        }

        // Thêm label và checkbox vào div container
        answerDiv.appendChild(newAnswerLabel);
        answerDiv.appendChild(newAnswerCheckBox);


        // Thêm div container vào vùng chứa
        answerContainerEdit.appendChild(answerDiv);
        answerContainerEdit.appendChild(newAnswerInput);

        // Tăng số lượng input answers đã được tạo
        answerCountEdit++;
//        console.log(answerCountEdit);

        // Cập nhật giá trị cho input "answerCountEdit"
        answerCountEditInput.value = answerCountEdit; //-->

        // Lấy danh sách tất cả các checkbox
        const checkboxes = document.querySelectorAll('.checkboxQuestion');

        if (selectedOption === "True") {
            const addQuestionButtonEdit = document.getElementById('addQuestionButtonEdit');
            if (newAnswerInput.id < 3) {
                if (answerCountEdit < 3) {
                    addQuestionButtonEdit.disabled = true;
                    addQuestionButtonEdit.style.backgroundColor = "gray";
                    document.getElementById("messAnswer").innerHTML = "Must be at least 3 answer";
                } else {
                    addQuestionButtonEdit.disabled = false;
                    addQuestionButtonEdit.style.backgroundColor = "#F26F21";
                    document.getElementById("messAnswer").innerHTML = "";
                }
            }
        } else if (selectedOption === "False") {

//            if (newAnswerInput.id < 2) {

            var checkbox1 = document.getElementById("answerCheckBox1");
            if (answerCountEdit < 2) {
                checkbox1.disabled = true;
                addQuestionButtonEdit.disabled = true;
                addQuestionButtonEdit.style.backgroundColor = "gray";
                document.getElementById("messAnswer").innerHTML = "Must be at least 2 answer";
            } else {
                checkbox1.disabled = false;
                addQuestionButtonEdit.disabled = true;
                addQuestionButtonEdit.style.backgroundColor = "gray";
                document.getElementById("messAnswer").innerHTML = "";
            }
//            }

        } else if (questionTypeEditSelect.value === "Select insert question") {
            addQuestionButtonEdit.disabled = true;
            addQuestionButtonEdit.style.backgroundColor = "#gray";
            document.getElementById("messAnswer").innerHTML = "Choose question type";
        }

        // Sự kiện khi một checkbox được chọn
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', (event) => {
                // Duyệt qua tất cả các checkbox và hủy chọn chúng (nếu không phải là checkbox hiện đang được chọn)
                if (questionTypeEditSelect.value === "False") {
                    checkboxes.forEach(otherCheckbox => {

                        const selectedCheckboxCount = document.querySelectorAll('.checkboxQuestion:checked').length;
                        checkboxCountEdit = selectedCheckboxCount;
                        checkboxCountEditInput.value = checkboxCountEdit;
                        if (selectedCheckboxCount < 1) {

                            addQuestionButtonEdit.disabled = true;
                            addQuestionButtonEdit.style.backgroundColor = "gray";
                            document.getElementById("messAnswer").innerHTML = "Must be 1 correct answer and 2 answer";
                        } else {

                            addQuestionButtonEdit.disabled = false;
                            addQuestionButtonEdit.style.backgroundColor = "#F26F21";
                            document.getElementById("messAnswer").innerHTML = "";
                        }
                        if (otherCheckbox !== checkbox) {
                            otherCheckbox.checked = false;
                        }

                    });
//                    // Kiểm tra trạng thái của checkbox hiện tại
//                    if (checkbox.checked) {
//                        // Nếu checkbox được chọn, hiển thị textarea "Explain"
//                        explainTextareaEdit.style.display = 'block';
//                    } else {
//                        // Nếu checkbox không được chọn, ẩn textarea "Explain"
//                        explainTextareaEdit.style.display = 'none';
//                    }
                } else {
                    // Duyệt qua tất cả các checkbox và không cho người dùng chọn quá số lượng answerCountEdit
                    checkboxes.forEach(checkbox => {
                        // Lấy số lượng checkbox đã được chọn
                        const selectedCheckboxCount = document.querySelectorAll('.checkboxQuestion:checked').length;
                        checkboxCountEdit = selectedCheckboxCount;
                        checkboxCountEditInput.value = checkboxCountEdit;
                        console.log(selectedCheckboxCount);
                        // Nếu số lượng checkbox đã được chọn lớn hơn hoặc bằng số lượng answerCountEdit đang có, hãy hủy chọn checkbox hiện tại
                        if (selectedCheckboxCount >= answerCountEdit) {
                            checkbox.checked = false;
                        }
                        if (selectedCheckboxCount < 2) {
                            document.getElementById("messAnswer").innerHTML = "Must be at least 2 correct answer";
                            addQuestionButtonEdit.disabled = true;
                            addQuestionButtonEdit.style.backgroundColor = "gray";
                        } else {
                            document.getElementById("messAnswer").innerHTML = "";
                            addQuestionButtonEdit.disabled = false;
                            addQuestionButtonEdit.style.backgroundColor = "#F26F21";
                        }
                    });

                }
                explainTextareaEdit.style.display = 'block';
            });
        });
    }
});

// Sự kiện khi thẻ select "questionTypeEditSelect" được thay đổi
questionTypeEditSelect.addEventListener('change', () => {
    // Lấy giá trị của select
//    const selectedOption = questionTypeEditSelect.value;
    const checkboxCountEditInput = document.getElementById('checkboxCountEdit');
    checkboxCountEditInput.value = 0;
    const addQuestionButtonEdit = document.getElementById('addQuestionButtonEdit');
    addQuestionButtonEdit.disabled = true;
    addQuestionButtonEdit.style.backgroundColor = "gray";
    if (questionTypeEditSelect.value === "True") {
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
    explainTextareaEdit.style.display = 'none';
});


