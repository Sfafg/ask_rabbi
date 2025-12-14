import React, { useState } from "react";
import { TextInput } from "../../Input";
import { SubmitButton } from "../../Buttons/";
interface SearchBarProps {
	onSearch: (phrase: string) => {};
}

const SearchBar: React.FC<SearchBarProps> = ({ onSearch }) => {
	const [phrase, setPhrase] = useState("");

	async function onSubmit(e: React.FormEvent) {
		e.preventDefault();
		onSearch(phrase);
	}

	return (
		<>
			<form onSubmit={onSubmit}>
				<TextInput
					label="Search a phrase"
					type="text"
					value={phrase}
					onChange={setPhrase}
				/>
				<SubmitButton label="Search" />
			</form>
		</>
	);
};
export default SearchBar;
