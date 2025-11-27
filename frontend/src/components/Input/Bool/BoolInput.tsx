import React from "react";

interface BoolInputProps {
  label: string;
  checked: boolean;
  onChange: (value: boolean) => void;
}

const BoolInput: React.FC<BoolInputProps> = ({label, checked, onChange}) => {
  return (
    <div>
    <label>{label} </label>
    <input type="checkbox" checked={checked} onChange={e=>onChange(e.target.checked)} />
    </div>
  );
};

export default BoolInput;
