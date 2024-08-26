import React from "react";
import FormLogin from "./components/FormLogin";
import { Metadata } from "next";

export const metadata: Metadata = {
  title: "Login",
  description: "Login page",
};

const LoginPage = () => {
  return (
    <div className="flex flex-col justify-center text-center w-full h-full md:content-center">
      <FormLogin />
    </div>
  );
};

export default LoginPage;
