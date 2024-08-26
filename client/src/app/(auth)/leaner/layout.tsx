import Image from "next/image";
import loginLeftImage from "@public/images/Illustrations.png";

type AuthLayoutProps = {
  children: React.ReactNode;
};

export default function AuthLayout({ children }: AuthLayoutProps) {
  return (
    <main className="w-screen h-screen bg-gray-400 flex">
      <div className="flex flex-col md:flex-row w-3/5 h-4/5 m-auto bg-white">
        <div className="w-2/5 md:relative md:block hidden">
          <Image
            src={loginLeftImage}
            alt="LoginLeftImage"
            fill
            objectFit="cover"
          />
        </div>
        <div className="md:w-3/5 w-full h-full">{children}</div>
      </div>
    </main>
  );
}
