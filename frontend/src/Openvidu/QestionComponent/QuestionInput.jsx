import axios from "axios";
import { useState, useRef } from "react";
import { useRecoilValue } from "recoil";
import { conference, user, APIroot } from "../../Store";
const QuestionInput = () => {
  const [questionInput, setQuestionInput] = useState("");
  const inputTag = useRef(null);

  const loginUser = useRecoilValue(user);
  const conferenceData = useRecoilValue(conference);
  const API = useRecoilValue(APIroot);
  console.log("conferenceData:", conferenceData, "loginUser:", loginUser);

  const questionHandler = (e) => {
    const newInput = e.target.value;
    setQuestionInput(newInput);
  };

  const enterClickHandler = (event) => {
    if (event.key === 'Enter') {
      inputHandler();
    }
  };


  const inputHandler = (e) => {
    axios({
      method: "POST",
      url: `${API}/conferenceQna`,
      headers: {
        "Content-Type": "application/json",
      },
      data: {
        conferencePk: `${conferenceData.conferencePk}`,
        groupPk: `${conferenceData.groupPk}`,
        conferenceQuestionContents: `${questionInput}`,
        userPk: loginUser.userPk,
      },
    })
      .then((response) => {
        console.log(response.data);
        inputTag.current.value = "";
        setQuestionInput("");
      })
      .catch((err) => {
        console.log(err);
      });
  };
  return (
    <div>
      <input
        type="text"
        onKeyPress={enterClickHandler}

        onChange={questionHandler}
        ref={inputTag}
        style={{
          marginTop: "1vh",
          width: "46vh",
          height: "4vh",
          borderRadius: "5px",
          border: "2px solid grey",
        }}
      />
      <button  onClick={inputHandler} style={{ marginLeft: "41.4vh" }}>
        입력
      </button>
    </div>
  );
};
export default QuestionInput;