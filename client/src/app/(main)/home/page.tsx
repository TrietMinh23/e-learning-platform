import type { Metadata } from "next";
import CreateCourseForm from "./components/CreateCourseForm";

export const metadata: Metadata = {
  title: "Home Page",
  description: "Home Page Description",
};

const ProfilePage = () => {
  return (
    <div className="w-full flex justify-center my-5 h-full items-center">
      <CreateCourseForm />
    </div>
  );
};
export default ProfilePage;
