import { Container } from 'core/container';
import { HeaderSpacing } from 'core/header/spacing';

import MeImage from './me.jpg';
import { Personal } from './personal';

// TODO: Add section on website stack

export const About = () => {
  return (
    <Container>
      <HeaderSpacing />
      <div className="flex py-10 space-x-16 justify-center">
        <img src={MeImage} alt="JJ" className="mb-4 max-h-96" />
        <section>
          <Personal />
        </section>
      </div>
    </Container>
  );
};
