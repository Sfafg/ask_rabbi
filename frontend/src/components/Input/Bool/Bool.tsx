import React from "react";

interface BoolProps {
  label: string;
  checked: boolean;
  onChange: (value: boolean) => void;
}

const Bool: React.FC<BoolProps> = ({label, checked, onChange}) => {
  return (
    <>
    <label>{label}</label>
    <input type="checkbox" checked={checked} onChange={e=>onChange(e.target.checked)}> </input>
    </>
  );
};

export default Bool;
