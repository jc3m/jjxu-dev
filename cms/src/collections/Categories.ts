import type { CollectionConfig } from 'payload/types';

const Categories: CollectionConfig = {
  slug: 'categories',
  access: {
    delete: () => false,
    read: () => true,
  },
  admin: {
    useAsTitle: 'title',
  },
  fields: [
    {
      name: 'title',
      type: 'text',
    },
  ],
};

export default Categories;
