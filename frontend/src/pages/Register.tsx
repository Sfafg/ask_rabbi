import { RegisterForm } from "../components/Form/";

interface RegisterProps {
	setRole: (value: string) => void;
}

function Register({ setRole }: RegisterProps) {
	return (
		<>
			<RegisterForm setRole={setRole} />
		</>
	);
}

export default Register;
