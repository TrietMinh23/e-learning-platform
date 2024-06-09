import { User } from 'src/modules/users/entities/user.entity';
import { define } from 'typeorm-seeding';
import * as Faker from 'faker';

define(User, (faker: typeof Faker) => {
  const user = new User();
  user.name = faker.name.findName();
  user.email = faker.internet.email();
  user.password = faker.random.word();
  return user;
});
