<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add</title>
    <style>
        .answer {
            display: none;
        }
    </style>
</head>
<body>
    <h1>Add question</h1>
    <label for="question">Question:</label>
    <input type="text" id="question" name="question"><br><br>

    <label for="type">Question type:</label><br>
    <input type="radio" id="questionType" name="type" value="0" name="questionType"> Single Choice<br>
    <input type="radio" id="questionType" name="type" value="1" name="questionType"> Multiple Choice<br><br>

    <button onclick="addAnswer()">Add answer</button><br><br>

    <div id="answers"></div>

    <script>
        let questionTypeSelected = false;

        function addAnswer() {
            if (questionTypeSelected) {
                return;
            }

            const type = document.querySelector('input[name="type"]:checked').value;
            const answersDiv = document.getElementById("answers");

            if (type === "1") {
                const answerInput = document.createElement("input");
                answerInput.type = "text";
                answerInput.name = "answers";
                answerInput.placeholder = "Answer";

                const checkbox = document.createElement("input");
                checkbox.type = "checkbox";
                checkbox.name = "correct";
                checkbox.id = "correct";
                const checkboxLabel = document.createElement("label");
                checkboxLabel.innerHTML = "Correct answer";

                const br = document.createElement("br");

                answersDiv.appendChild(answerInput);
                answersDiv.appendChild(checkbox);
                answersDiv.appendChild(checkboxLabel);
            }
            else if (type === "0") {
                const answerInput = document.createElement("input");
                answerInput.type = "text";
                answerInput.name = "answers";
                answerInput.placeholder = "Answer";

                const radio = document.createElement("input");
                radio.type = "radio";
                radio.name = "correct";
                radio.id = "correct";
                const radioLabel = document.createElement("label");
                radioLabel.innerHTML = "Correct answer";

                const br = document.createElement("br");

                answersDiv.appendChild(answerInput);
                answersDiv.appendChild(radio);
                answersDiv.appendChild(radioLabel);
            }

            answersDiv.appendChild(br);

            questionTypeSelected = true;
            document.getElementById("single").disabled = true;
            document.getElementById("multiple").disabled = true;
        }
    </script>
</body>
</html>
