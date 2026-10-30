const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcrypt');
const prisma = new PrismaClient();

async function main() {
  const etabs = [
    { name: 'BNA Tizi Ouzou Centre', type: 'bank', wilayaId: 15, email: 'bna.tizi@bna.dz', phone: '026300100' },
    { name: 'CPA Alger Didouche', type: 'bank', wilayaId: 16, email: 'cpa.alger@cpa.dz', phone: '021300200' },
    { name: 'CHU Tizi Ouzou', type: 'hospital', wilayaId: 15, email: 'chu.tizi@sante.dz', phone: '026300300' },
    { name: 'EPH Blida Centre', type: 'hospital', wilayaId: 9, email: 'eph.blida@sante.dz', phone: '025300400' },
    { name: 'APC Tizi Ouzou', type: 'administration', wilayaId: 15, email: 'apc.tizi@gov.dz', phone: '026300500' },
    { name: 'Algerie Poste Alger', type: 'post', wilayaId: 16, email: 'poste.alger@poste.dz', phone: '021300600' },
    { name: 'CAAT Oran', type: 'insurance', wilayaId: 31, email: 'caat.oran@caat.dz', phone: '041300700' },
    { name: 'Mobilis Tizi Ouzou', type: 'telecom', wilayaId: 15, email: 'mobilis.tizi@mobilis.dz', phone: '026300800' },
    { name: 'Djezzy Alger Centre', type: 'telecom', wilayaId: 16, email: 'djezzy.alger@djezzy.dz', phone: '021300900' },
    { name: 'CNEP Constantine', type: 'bank', wilayaId: 25, email: 'cnep.constantine@cnep.dz', phone: '031301000' },
  ];

  for (const e of etabs) {
    const slug = e.name.toLowerCase().replace(/[^a-z0-9]+/g, '-') + '-' + Date.now();
    const org = await prisma.organization.create({
      data: { name: e.name, slug, type: e.type, email: e.email, phone: e.phone, isActive: true }
    });
    await prisma.branch.create({
      data: { name: e.name, address: e.name, organizationId: org.id, wilayaId: e.wilayaId, isActive: true }
    });
    const hash = await bcrypt.hash('Admin@123456', 10);
    await prisma.user.create({
      data: { email: e.email, passwordHash: hash, firstName: 'Admin', lastName: e.name.split(' ')[0], role: 'ORG_ADMIN', organizationId: org.id }
    });
    console.log('Created:', e.name);
  }
  console.log('Done!');
}

main().catch(console.error).finally(() => prisma.$disconnect());