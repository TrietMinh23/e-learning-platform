import StudentHeader from "@/components/header/student-header/StudentHeader";

type EditProfileProps = {
  children: React.ReactNode;
}

export default function EditProfileLayout({children}: EditProfileProps) {
  const contentName: string = "Edit Profile";

  return (
    <main>
      <StudentHeader contentName={contentName} />
      {children}
    </main>
  )
}