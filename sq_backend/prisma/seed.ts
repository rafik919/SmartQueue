import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcrypt';

const prisma = new PrismaClient();

const wilayas = [
  { id: 1,  name: 'Adrar',          nameAr: 'أدرار',          code: '01' },
  { id: 2,  name: 'Chlef',          nameAr: 'الشلف',          code: '02' },
  { id: 3,  name: 'Laghouat',       nameAr: 'الأغواط',        code: '03' },
  { id: 4,  name: 'Oum El Bouaghi', nameAr: 'أم البواقي',     code: '04' },
  { id: 5,  name: 'Batna',          nameAr: 'باتنة',           code: '05' },
  { id: 6,  name: 'Béjaïa',         nameAr: 'بجاية',           code: '06' },
  { id: 7,  name: 'Biskra',         nameAr: 'بسكرة',           code: '07' },
  { id: 8,  name: 'Béchar',         nameAr: 'بشار',            code: '08' },
  { id: 9,  name: 'Blida',          nameAr: 'البليدة',         code: '09' },
  { id: 10, name: 'Bouira',         nameAr: 'البويرة',         code: '10' },
  { id: 11, name: 'Tamanrasset',    nameAr: 'تمنراست',         code: '11' },
  { id: 12, name: 'Tébessa',        nameAr: 'تبسة',            code: '12' },
  { id: 13, name: 'Tlemcen',        nameAr: 'تلمسان',          code: '13' },
  { id: 14, name: 'Tiaret',         nameAr: 'تيارت',           code: '14' },
  { id: 15, name: 'Tizi Ouzou',     nameAr: 'تيزي وزو',        code: '15' },
  { id: 16, name: 'Alger',          nameAr: 'الجزائر',         code: '16' },
  { id: 17, name: 'Djelfa',         nameAr: 'الجلفة',          code: '17' },
  { id: 18, name: 'Jijel',          nameAr: 'جيجل',            code: '18' },
  { id: 19, name: 'Sétif',          nameAr: 'سطيف',            code: '19' },
  { id: 20, name: 'Saïda',          nameAr: 'سعيدة',           code: '20' },
  { id: 21, name: 'Skikda',         nameAr: 'سكيكدة',          code: '21' },
  { id: 22, name: 'Sidi Bel Abbès', nameAr: 'سيدي بلعباس',    code: '22' },
  { id: 23, name: 'Annaba',         nameAr: 'عنابة',           code: '23' },
  { id: 24, name: 'Guelma',         nameAr: 'قالمة',           code: '24' },
  { id: 25, name: 'Constantine',    nameAr: 'قسنطينة',         code: '25' },
  { id: 26, name: 'Médéa',          nameAr: 'المدية',          code: '26' },
  { id: 27, name: 'Mostaganem',     nameAr: 'مستغانم',         code: '27' },
  { id: 28, name: "M'Sila",         nameAr: 'المسيلة',         code: '28' },
  { id: 29, name: 'Mascara',        nameAr: 'معسكر',           code: '29' },
  { id: 30, name: 'Ouargla',        nameAr: 'ورقلة',           code: '30' },
  { id: 31, name: 'Oran',           nameAr: 'وهران',           code: '31' },
  { id: 32, name: 'El Bayadh',      nameAr: 'البيض',           code: '32' },
  { id: 33, name: 'Illizi',         nameAr: 'إليزي',           code: '33' },
  { id: 34, name: 'Bordj Bou Arréridj', nameAr: 'برج بوعريريج', code: '34' },
  { id: 35, name: 'Boumerdès',      nameAr: 'بومرداس',         code: '35' },
  { id: 36, name: 'El Tarf',        nameAr: 'الطارف',          code: '36' },
  { id: 37, name: 'Tindouf',        nameAr: 'تندوف',           code: '37' },
  { id: 38, name: 'Tissemsilt',     nameAr: 'تيسمسيلت',        code: '38' },
  { id: 39, name: 'El Oued',        nameAr: 'الوادي',          code: '39' },
  { id: 40, name: 'Khenchela',      nameAr: 'خنشلة',           code: '40' },
  { id: 41, name: 'Souk Ahras',     nameAr: 'سوق أهراس',       code: '41' },
  { id: 42, name: 'Tipaza',         nameAr: 'تيبازة',          code: '42' },
  { id: 43, name: 'Mila',           nameAr: 'ميلة',            code: '43' },
  { id: 44, name: 'Aïn Defla',      nameAr: 'عين الدفلى',      code: '44' },
  { id: 45, name: 'Naâma',          nameAr: 'النعامة',         code: '45' },
  { id: 46, name: 'Aïn Témouchent', nameAr: 'عين تموشنت',      code: '46' },
  { id: 47, name: 'Ghardaïa',       nameAr: 'غرداية',          code: '47' },
  { id: 48, name: 'Relizane',       nameAr: 'غليزان',          code: '48' },
];

const communes = [
  { name: 'Alger Centre',     nameAr: 'الجزائر الوسطى',    wilayaId: 16 },
  { name: 'Bab El Oued',      nameAr: 'باب الواد',          wilayaId: 16 },
  { name: 'Hussein Dey',      nameAr: 'حسين داي',           wilayaId: 16 },
  { name: 'Kouba',            nameAr: 'القبة',              wilayaId: 16 },
  { name: 'Bab Ezzouar',      nameAr: 'باب الزوار',         wilayaId: 16 },
  { name: 'Bir Mourad Raïs',  nameAr: 'بئر مراد رايس',     wilayaId: 16 },
  { name: 'Hydra',            nameAr: 'حيدرة',              wilayaId: 16 },
  { name: 'Ben Aknoun',       nameAr: 'بن عكنون',           wilayaId: 16 },
  { name: 'Dar El Beïda',     nameAr: 'دار البيضاء',        wilayaId: 16 },
  { name: 'Rouiba',           nameAr: 'رويبة',              wilayaId: 16 },
  { name: 'Oran',             nameAr: 'وهران',              wilayaId: 31 },
  { name: 'Es Sénia',         nameAr: 'السانية',            wilayaId: 31 },
  { name: 'Bir El Djir',      nameAr: 'بئر الجير',          wilayaId: 31 },
  { name: 'Arzew',            nameAr: 'أرزيو',              wilayaId: 31 },
  { name: 'Ain Turk',         nameAr: 'عين الترك',          wilayaId: 31 },
  { name: 'Constantine',      nameAr: 'قسنطينة',            wilayaId: 25 },
  { name: 'El Khroub',        nameAr: 'الخروب',             wilayaId: 25 },
  { name: 'Hamma Bouziane',   nameAr: 'حامة بوزيان',        wilayaId: 25 },
  { name: 'Annaba',           nameAr: 'عنابة',              wilayaId: 23 },
  { name: 'El Bouni',         nameAr: 'البوني',             wilayaId: 23 },
  { name: 'Blida',            nameAr: 'البليدة',            wilayaId: 9  },
  { name: 'Boufarik',         nameAr: 'بوفاريك',            wilayaId: 9  },
  { name: 'Larbaâ',           nameAr: 'لاربعاء',            wilayaId: 9  },
  { name: 'Sétif',            nameAr: 'سطيف',               wilayaId: 19 },
  { name: 'El Eulma',         nameAr: 'العلمة',             wilayaId: 19 },
  { name: 'Batna',            nameAr: 'باتنة',              wilayaId: 5  },
  { name: 'Barika',           nameAr: 'باريكة',             wilayaId: 5  },
  { name: 'Tizi Ouzou',       nameAr: 'تيزي وزو',           wilayaId: 15 },
  { name: 'Azazga',           nameAr: 'عزازقة',             wilayaId: 15 },
  { name: 'Boumerdès',        nameAr: 'بومرداس',            wilayaId: 35 },
  { name: 'Tipaza',           nameAr: 'تيبازة',             wilayaId: 42 },
  { name: 'Koléa',            nameAr: 'قليعة',              wilayaId: 42 },
  { name: 'Béjaïa',           nameAr: 'بجاية',              wilayaId: 6  },
  { name: 'Tlemcen',          nameAr: 'تلمسان',             wilayaId: 13 },
  { name: 'Biskra',           nameAr: 'بسكرة',              wilayaId: 7  },
  { name: 'Ouargla',          nameAr: 'ورقلة',              wilayaId: 30 },
  { name: 'Hassi Messaoud',   nameAr: 'حاسي مسعود',         wilayaId: 30 },
  { name: 'Médéa',            nameAr: 'المدية',             wilayaId: 26 },
  { name: 'Mostaganem',       nameAr: 'مستغانم',            wilayaId: 27 },
  { name: 'Ghardaïa',         nameAr: 'غرداية',             wilayaId: 47 },
];

async function main() {
  console.log('🌱 Seeding wilayas et communes...');

  for (const w of wilayas) {
    await prisma.wilaya.upsert({ where: { id: w.id }, update: {}, create: w });
  }
  console.log(`✅ ${wilayas.length} wilayas créées`);

  for (let i = 0; i < communes.length; i++) {
    await prisma.commune.upsert({
      where: { id: i + 1 },
      update: {},
      create: { id: i + 1, ...communes[i] },
    });
  }
  console.log(`✅ ${communes.length} communes créées`);

  await prisma.user.upsert({
    where: { email: 'admin@smartqueue.app' },
    update: {},
    create: {
      email: 'admin@smartqueue.app',
      passwordHash: await bcrypt.hash('Admin@123456', 12),
      firstName: 'Super', lastName: 'Admin',
      role: 'SUPER_ADMIN', isEmailVerified: true,
    },
  });

  await prisma.user.upsert({
    where: { email: 'demo@smartqueue.app' },
    update: {},
    create: {
      email: 'demo@smartqueue.app',
      passwordHash: await bcrypt.hash('Demo@123456', 12),
      firstName: 'Sara', lastName: 'Benali',
      role: 'CLIENT', isEmailVerified: true,
    },
  });

  const org = await prisma.organization.upsert({
    where: { slug: 'bna-algerie' },
    update: {},
    create: {
      name: "Banque Nationale d'Algérie",
      nameAr: 'البنك الوطني الجزائري',
      slug: 'bna-algerie', type: 'bank',
      isVerified: true, isActive: true,
    },
  });

  await prisma.user.upsert({
    where: { email: 'admin@bna.dz' },
    update: {},
    create: {
      email: 'admin@bna.dz',
      passwordHash: await bcrypt.hash('Admin@123456', 12),
      firstName: 'Admin', lastName: 'BNA',
      role: 'ORG_ADMIN', isEmailVerified: true,
      organizationId: org.id,
    },
  });

  await prisma.user.upsert({
    where: { email: 'agent@bna.dz' },
    update: {},
    create: {
      email: 'agent@bna.dz',
      passwordHash: await bcrypt.hash('Agent@123456', 12),
      firstName: 'Amine', lastName: 'Khelifa',
      role: 'AGENT', isEmailVerified: true,
      organizationId: org.id,
    },
  });

  const algerCentre = await prisma.commune.findFirst({ where: { name: 'Alger Centre' } });

  const branch = await prisma.branch.upsert({
    where: { id: 'seed-branch-bna-001' },
    update: {},
    create: {
      id: 'seed-branch-bna-001',
      name: 'Agence Didouche Mourad',
      nameAr: 'وكالة ديدوش مراد',
      address: '12 Rue Didouche Mourad',
      latitude: 36.7372, longitude: 3.0862,
      phone: '+213 21 73 45 67',
      organizationId: org.id,
      wilayaId: 16,
      communeId: algerCentre?.id,
    },
  });

  for (let day = 0; day <= 6; day++) {
    await prisma.openingHours.upsert({
      where: { branchId_dayOfWeek: { branchId: branch.id, dayOfWeek: day } },
      update: {},
      create: {
        branchId: branch.id, dayOfWeek: day,
        openTime: '08:30', closeTime: '16:30',
        isClosed: day === 5 || day === 6,
      },
    });
  }

  const svcs = [
    { code: 'VIR', name: 'Virements',       nameAr: 'التحويلات',      avg: 15, prefix: 'V' },
    { code: 'DEP', name: 'Dépôts/Retraits', nameAr: 'الإيداع/السحب', avg: 8,  prefix: 'D' },
    { code: 'CRE', name: 'Crédits',         nameAr: 'القروض',          avg: 25, prefix: 'C' },
    { code: 'REN', name: 'Renseignements',  nameAr: 'المعلومات',       avg: 5,  prefix: 'R' },
  ];

  for (const svc of svcs) {
    const service = await prisma.service.upsert({
      where: { id: `seed-svc-bna-${svc.code}` },
      update: {},
      create: {
        id: `seed-svc-bna-${svc.code}`,
        name: svc.name, nameAr: svc.nameAr, code: svc.code,
        avgServiceTime: svc.avg, organizationId: org.id,
      },
    });
    await prisma.queue.upsert({
      where: { id: `seed-q-bna-${svc.code}` },
      update: {},
      create: {
        id: `seed-q-bna-${svc.code}`,
        name: `File ${svc.name}`, prefix: svc.prefix,
        branchId: branch.id, serviceId: service.id,
        avgServiceTime: svc.avg, status: 'ACTIVE',
      },
    });
  }

  for (let i = 1; i <= 4; i++) {
    await prisma.counter.upsert({
      where: { branchId_number: { branchId: branch.id, number: i } },
      update: {},
      create: { name: `Guichet 0${i}`, number: i, branchId: branch.id, status: 'CLOSED' },
    });
  }

  console.log('✅ BNA seed terminé');
  console.log('');
  console.log('📋 Comptes :');
  console.log('  Super Admin : admin@smartqueue.app / Admin@123456');
  console.log('  Org Admin   : admin@bna.dz          / Admin@123456');
  console.log('  Agent       : agent@bna.dz           / Agent@123456');
  console.log('  Client      : demo@smartqueue.app    / Demo@123456');
}

main().catch(console.error).finally(() => prisma.$disconnect());
