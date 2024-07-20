import { createSeedClient } from "@snaplet/seed";
import { copycat } from '@snaplet/copycat';
import * as bcrypt from 'bcrypt';
import { PrismaClient } from "@prisma/client";

// npx prisma db seed 
// npx @snaplet/seed sync  
// npx prisma migrate dev
// npx prisma db pull  

const hashPassword = async (password: string): Promise<string> => {
  const saltOrRounds = 10;
  return bcrypt.hash(password, saltOrRounds);
};

const generateUsers = async (seed, count: number, role: 'admin' | 'instructor' | 'learner', domain: string) => {
  const users = await seed.user((x) => x(count, {
    email: (ctx) => copycat.email(ctx.seed, { domain }),
    full_name: (ctx) => copycat.fullName(ctx.seed),
    position: role.charAt(0).toUpperCase() + role.slice(1),
    password: async () => await hashPassword('defaultpassword'), // Use a default password for simplicity
    role
  }));

  return users.user;
};

const main = async () => {
  const seed = await createSeedClient({ dryRun: false });
  const prisma = new PrismaClient();

  try {
    // Truncate all tables in the database
    await seed.$resetDatabase();

    // Create 1 admin
    await generateUsers(seed, 1, 'admin', '@admin.com');

    // Create 1000 instructors
    await generateUsers(seed, 2, 'instructor', '@instructor.com');

    // Create 1000 learners
    await generateUsers(seed, 2, 'learner', '@learner.com');

    const numCourse = 10;

    // Retrieve all learners and instructors
    const [learners, instructors, admin] = await Promise.all([
      prisma.user.findMany({ where: { role: 'learner' } }),
      prisma.user.findMany({ where: { role: 'instructor' } }),
      prisma.user.findMany({ where: { role: 'admin' } })
    ]);

    // Create learner records
    await seed.learner((x) => x(learners.length, (ctx) => ({
      learner_id: learners[ctx.index].id,
      learner_default_language: copycat.oneOf(ctx.seed, ['en', 'es', 'fr', 'de', 'it', 'pt', 'ru', 'zh'])
    })));

    await seed.admin((x) => x(admin.length, (ctx) => ({
      admin_id: admin[ctx.index].id
    })));

    // Create instructor records
    await seed.instructor((x) => x(instructors.length, (ctx) => ({
      instructor_id: instructors[ctx.index].id,
      date_of_birth: copycat.dateString(ctx.seed),
      address: copycat.postalAddress(ctx.seed),
      phone: copycat.phoneNumber(ctx.seed, { prefixes: ['0'], length: 10 }),
      academic_degree: copycat.oneOf(ctx.seed, ['BSc', 'MSc', 'PhD', 'Other']),
      working_unit: copycat.oneOf(ctx.seed, ['Department of Computer Science', 'Department of Mathematics', 'Department of Physics', 'Department of Chemistry', 'Department of Biology']),
      academic_title: copycat.oneOf(ctx.seed, ['Professor', 'Associate Professor', 'Assistant Professor', 'Lecturer', 'Researcher']),
      description: copycat.paragraph(ctx.seed, { minSentences: 3 }),
      instructor_type: instructors[ctx.index].id % 2 ? 'instructor' : 'vip_instructor'
    })));

    const vipInstructors = await prisma.instructor.findMany({ where: { instructor_type: 'vip_instructor' } });

    // Create VIP instructor records
    await seed.vipInstructor((x) => x(vipInstructors.length, (ctx) => ({
      vip_instructor_id: vipInstructors[ctx.index].instructor_id,
      country: copycat.country(ctx.seed),
      zip_code: copycat.int(ctx.seed, { min: 100000, max: 999999 }).toString(),
      tin_number: copycat.int(ctx.seed, { min: 100000000, max: 999999999 }).toString(),
      tax_filling_date: copycat.dateString(ctx.seed),
      image: copycat.url(ctx.seed)
    })));

    const nameCategories = ['Programming', 'Mathematics', 'Physics', 'Chemistry', 'Biology', 'Development', 'Design', 'Business', 'Marketing', 'Health'];
    const { category } = await seed.category((x) => x(10, ({ index }) => ({
      category_name: nameCategories[index]
    })));

    const categoryIds = category.map(cat => cat.category_id);

    await seed.subCategory(x => x(20, (ctx) => ({
      category_id: copycat.oneOf(ctx.seed, categoryIds),
    })));

    await seed.tier((x) => x(10, ({ index }) => ({
      price: index * 100000 + 230000
    })));


    await seed.course((x) => x(numCourse, (ctx) => ({
      title: copycat.scramble(ctx.seed),
      description: copycat.paragraph(ctx.seed, { minSentences: 3 }),
      subtitle: copycat.scramble(ctx.seed),
      language: copycat.oneOf(ctx.seed, ['en', 'es', 'fr', 'de', 'it', 'pt', 'ru', 'zh']),
      requirement: copycat.paragraph(ctx.seed, { minSentences: 3 }).substring(0, 160),
      image: copycat.url(ctx.seed),
      subcategory_id: copycat.oneOf(ctx.seed, seed.$store.subCategory.map((subcategory) => subcategory.id)),
      status: copycat.oneOf(ctx.seed, ['pending', 'approved', 'rejected'] as const),
      tier_id: copycat.oneOf(ctx.seed, seed.$store.tier.map((tier) => tier.id)),
    })));

    await seed.courseObjective((x) => x(numCourse, (ctx) => ({
      course_id: copycat.oneOf(ctx.seed, seed.$store.course.map((course) => course.id)),
      course_objective: copycat.paragraph(ctx.seed, { minSentences: 3 }).substring(0, 160)
    })));

    const courses = await prisma.course.findMany();
    const sections = [];

    for (let i = 0; i < numCourse * 4; i++) {
      var orderId = i + 1;
      sections.push({
        id: i + 1,
        course_id: copycat.oneOf({ seed: i }, courses.map(course => course.id)),
        title: copycat.words({ seed: i, min: 1, max: 3 }).substring(0, 80),
        status: copycat.oneOf({ seed: i }, ['pending', 'publish', 'unpublish']),
        order_section_id: orderId,
        number_of_item: 0
      });
    }

    // console.log(sections);

    // Create sections with the correct `order_section_id`
    await seed.section((x) => x(sections.length, (ctx) => sections[ctx.index]));

    // await prisma.section.updateMany({
    //   where: {
    //     order_section_id: 1, // Giả sử phần tử đầu tiên có order_section_id là 1
    //   },
    //   data: {
    //     order_section_id: null,
    //   },
    // });

    // // Cập nhật các phần tử còn lại để giảm giá trị order_section_id đi 1
    // await prisma.section.updateMany({
    //   where: {
    //     order_section_id: {
    //       not: 1, // Chỉ cập nhật các phần tử không phải là null
    //     },
    //   },
    //   data: {
    //     order_section_id: {
    //       decrement: 1,
    //     },
    //   },
    // });

    await seed.notification((x) => x(10, (ctx) => ({
      content: copycat.paragraph(ctx.seed, { minSentences: 3 }),
      course_id: seed.$store.course[ctx.index].id,
      notification_type: copycat.oneOf(ctx.seed, ['adjustment', 'promotional_program', 'course_highlight', 'price_conversion', 'start_of_course', 'end_of_course'] as const)
    })));

    await seed.courseHighlight((x) => x(courses.length, (ctx) => ({
      id: seed.$store.course[ctx.index].id,
      downloadable_documents: copycat.int(ctx.seed, { min: 1, max: 10 }),
      students_enrolled: copycat.int(ctx.seed, { min: 1, max: 1000 }),
      average_rating: copycat.float(ctx.seed, { min: 1, max: 5 }),
      sale_price: copycat.int(ctx.seed, { min: 0, max: 2499000 }),
      no_sections: copycat.int(ctx.seed, { min: 1, max: 10 }),
      duration: copycat.int(ctx.seed, { min: 1, max: 10000 }),
    })));


    // await seed.courseInstructor((x) => x(numCourse, (ctx) => ({
    //   course_id: seed.$store.course[ctx.index].id,
    //   instructor_id: copycat.oneOf(ctx.seed, instructors.map(instructor => instructor.id))
    //   // instructor_id: seed.$store.instructor[ctx.index].instructor_id
    // })));

    const courseInstructors = await prisma.courseInstructor.findMany();

    // await seed.courseInstructorHistory((x) => x(courseInstructors.length, (ctx) => ({
    //   course_id: seed.$store.courseInstructor[ctx.index].course_id,
    //   instructor_id: seed.$store.courseInstructor[ctx.index].instructor_id,
    //   create_at: copycat.dateString(ctx.seed),
    //   course_profit_percent: 100,
    // })));









    console.log("Database seeded successfully!");
  } catch (error) {
    console.error("Error seeding database:", error);
  } finally {
    await prisma.$disconnect();
  }
};

main().catch((error) => {
  console.error("Unhandled error in main function:", error);
  process.exit(1);
});