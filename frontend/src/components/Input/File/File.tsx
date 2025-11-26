import React from "react";

interface FileProps {
  label: string;
  accept: string;
  onChange: (value: File | null) => void;
}

const File: React.FC<FileProps> = ({label, accept, onChange}) => {
  return (
    <>
    <label>{label}</label>
    <input type="file" accept={accept} onChange={e=>
        {
            if(e.target.files && e.target.files.length>0)onChange(e.target.files[0]) 
            else onChange(null)
        }}> </input>
    </>
  );
};

export default File;
