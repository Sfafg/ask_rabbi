import React from "react";
import { LoginForm } from "../components/Form/";

interface LoginProps {
	setRole: (value: string) => void;
}

function Login({ setRole }: LoginProps) {
	return <LoginForm setRole={setRole} />;
}

export default Login;
