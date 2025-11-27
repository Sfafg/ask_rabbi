import React from "react";

interface FileInputProps {
  label: string;
  accept: string;
  onChange: (value: File | null) => void;
}

const FileInput: React.FC<FileInputProps> = ({label, accept, onChange}) => {
  return (
    <div>
    <label>{label} </label>
    <input type="file" accept={accept} onChange={e=>
        {
            if(e.target.files && e.target.files.length>0)onChange(e.target.files[0]) 
            else onChange(null)
        }} />
    </div>
  );
};

export default FileInput;
