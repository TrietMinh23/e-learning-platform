import SearchBar from "./components/Search";

const InstructorHeader = ({ contentName }: { contentName: string }) => {
  contentName = "Create a new course";
  const currentTime = new Date();
  const currentHour = currentTime.getHours();

  let greeting;

  if (currentHour >= 5 && currentHour < 12) {
    greeting = "Good morning!";
  } else if (currentHour >= 12 && currentHour < 18) {
    greeting = "Good afternoon!";
  } else {
    greeting = "Good evening!";
  }
  return (
    <div className="h-20 w-full bg-primary-100 px-8 py-6">
      <div className="container mx-auto flex justify-between">
        <section className="flex items-center justify-between gap-6">
          <p className="body-medium text-gray-medium">{greeting}</p>
          <p className="body-xxl text-gray-dark">{contentName}</p>
        </section>
        <section className="flex">{<SearchBar />}</section>
      </div>
    </div>
  );
};

export default InstructorHeader;
