import styled from 'styled-components';
import Modal from '../../CommonComponents/Modal/Modal';
import axios from 'axios';
import { APIroot } from '../../Store';
import { user } from '../../Store';
import { useRecoilValue } from 'recoil';
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';

const GroupDeleteModal = ({onClose, groupPk}) => {
    const Title = "Group Delete";
    const navigate = useNavigate();
    const API = useRecoilValue(APIroot);

    const OkHandler = () => {
        axios({
            method: "PUT",
            url: `${API}/group/${groupPk}/delete`,
            headers: {
                "Content-Type": "application/json",
            }
        })
        .then((response) => {
            if(response.data === "success"){
                CancelHandler()
                navigate('/grouplist');
            }
        })
    }

    const CancelHandler = () => {
        onClose?.();
    }

    return (
        <Modal onClose={onClose} ModalTitle={Title}>
            <TitleStyle>
                <div>그룹을 정말 삭제하시겠습니까?</div>
            </TitleStyle>
            <TitleStyle>
          <CreateCancelButtonStyle>
            <button onClick={OkHandler}>Ok</button>
          </CreateCancelButtonStyle>
          <CreateCancelButtonStyle>
            <button onClick={CancelHandler}>Cancel</button>
          </CreateCancelButtonStyle>
        </TitleStyle>
        </Modal>
    )
}

export default GroupDeleteModal;

const TitleStyle = styled.div`
  display: flex;
  flex-direction: row;
  align-items: end; // 세로 기준 맨 아래
  height: 6vh;
  .name {
    display: flex;
    margin-right: 5px;
    width: 30%;
  }
  .input {
    display: flex;
    width: 60%;
  }
`;

const ButtonStyle = styled.div`
  display: flex;
  width: 50px;
  height: 25px;
  margin-left: 5px;
`;

const CreateCancelButtonStyle = styled.div`
  margin-left: 50px;
  padding-left: 50px;
  width: 5%;
  height: 25px;
`;