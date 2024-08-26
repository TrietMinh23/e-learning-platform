import React from "react";

import { Metadata } from "next";
import FormSignUp from "./components/FormSignUp";

export const metadata: Metadata = {
  title: "Sign Up",
  description: "Sign Up page",
};

const SignUpPage = () => {
  return (
    <div className="flex flex-col justify-center text-center w-full h-full md:content-center">
      <FormSignUp />
    </div>
  );
};

export default SignUpPage;
