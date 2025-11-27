import React from "react";

interface SubmitButtonProps {
  label: string;
  onClick?: ()=> void;
}

const SubmitButton: React.FC<SubmitButtonProps> = ({label, onClick=()=>{}}) => {
  return (
    <>
    <button type="submit" onClick={onClick}>{label}</button>
    </>
  );
};

export default SubmitButton;
