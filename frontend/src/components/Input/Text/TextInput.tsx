import React from "react";

interface TextInputProps {
	label: string;
	type: string;
	value: string;
	onChange: (value: string) => void;
}

const TextInput: React.FC<TextInputProps> = ({
	label,
	type,
	value,
	onChange,
}) => {
	return (
		<div>
			{label.length != 0 && <label>{label} </label>}
			<input
				type={type}
				value={value}
				onChange={(e) => {
					onChange(e.target.value);
				}}
			/>
		</div>
	);
};

export default TextInput;
