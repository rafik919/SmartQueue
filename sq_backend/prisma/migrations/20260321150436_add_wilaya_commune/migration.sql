/*
  Warnings:
  - You are about to drop the column `city` on the `branches` table.
  - You are about to drop the column `wilaya` on the `branches` table.
  - You are about to drop the column `city` on the `organizations` table.
  - You are about to drop the column `country` on the `organizations` table.
  - The `type` column on the `organizations` table would be dropped and recreated.
  - Added the required column `wilayaId` to the `branches` table.
*/

-- CreateEnum
CREATE TYPE "OrgType" AS ENUM ('bank', 'hospital', 'administration', 'post', 'insurance', 'telecom', 'other');

-- DropIndex
DROP INDEX "branches_city_idx";

-- DropIndex
DROP INDEX "organizations_slug_idx";

-- CreateTable wilayas (avant d'ajouter la FK)
CREATE TABLE "wilayas" (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "nameAr" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    CONSTRAINT "wilayas_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "wilayas_code_key" ON "wilayas"("code");

-- CreateTable communes
CREATE TABLE "communes" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "nameAr" TEXT,
    "code" TEXT,
    "wilayaId" INTEGER NOT NULL,
    CONSTRAINT "communes_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "communes_wilayaId_idx" ON "communes"("wilayaId");

-- AddForeignKey communes -> wilayas
ALTER TABLE "communes" ADD CONSTRAINT "communes_wilayaId_fkey" FOREIGN KEY ("wilayaId") REFERENCES "wilayas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- Insérer toutes les wilayas avant de modifier branches
INSERT INTO "wilayas" ("id", "name", "nameAr", "code") VALUES
(1,  'Adrar',          'أدرار',          '01'),
(2,  'Chlef',          'الشلف',          '02'),
(3,  'Laghouat',       'الأغواط',        '03'),
(4,  'Oum El Bouaghi', 'أم البواقي',     '04'),
(5,  'Batna',          'باتنة',           '05'),
(6,  'Béjaïa',         'بجاية',           '06'),
(7,  'Biskra',         'بسكرة',           '07'),
(8,  'Béchar',         'بشار',            '08'),
(9,  'Blida',          'البليدة',         '09'),
(10, 'Bouira',         'البويرة',         '10'),
(11, 'Tamanrasset',    'تمنراست',         '11'),
(12, 'Tébessa',        'تبسة',            '12'),
(13, 'Tlemcen',        'تلمسان',          '13'),
(14, 'Tiaret',         'تيارت',           '14'),
(15, 'Tizi Ouzou',     'تيزي وزو',        '15'),
(16, 'Alger',          'الجزائر',         '16'),
(17, 'Djelfa',         'الجلفة',          '17'),
(18, 'Jijel',          'جيجل',            '18'),
(19, 'Sétif',          'سطيف',            '19'),
(20, 'Saïda',          'سعيدة',           '20'),
(21, 'Skikda',         'سكيكدة',          '21'),
(22, 'Sidi Bel Abbès', 'سيدي بلعباس',    '22'),
(23, 'Annaba',         'عنابة',           '23'),
(24, 'Guelma',         'قالمة',           '24'),
(25, 'Constantine',    'قسنطينة',         '25'),
(26, 'Médéa',          'المدية',          '26'),
(27, 'Mostaganem',     'مستغانم',         '27'),
(28, 'M''Sila',        'المسيلة',         '28'),
(29, 'Mascara',        'معسكر',           '29'),
(30, 'Ouargla',        'ورقلة',           '30'),
(31, 'Oran',           'وهران',           '31'),
(32, 'El Bayadh',      'البيض',           '32'),
(33, 'Illizi',         'إليزي',           '33'),
(34, 'Bordj Bou Arréridj', 'برج بوعريريج', '34'),
(35, 'Boumerdès',      'بومرداس',         '35'),
(36, 'El Tarf',        'الطارف',          '36'),
(37, 'Tindouf',        'تندوف',           '37'),
(38, 'Tissemsilt',     'تيسمسيلت',        '38'),
(39, 'El Oued',        'الوادي',          '39'),
(40, 'Khenchela',      'خنشلة',           '40'),
(41, 'Souk Ahras',     'سوق أهراس',       '41'),
(42, 'Tipaza',         'تيبازة',          '42'),
(43, 'Mila',           'ميلة',            '43'),
(44, 'Aïn Defla',      'عين الدفلى',      '44'),
(45, 'Naâma',          'النعامة',         '45'),
(46, 'Aïn Témouchent', 'عين تموشنت',      '46'),
(47, 'Ghardaïa',       'غرداية',          '47'),
(48, 'Relizane',       'غليزان',          '48');

-- AlterTable branches : ajouter wilayaId nullable d'abord
ALTER TABLE "branches" DROP COLUMN "city",
DROP COLUMN "wilaya",
ADD COLUMN "addressAr" TEXT,
ADD COLUMN "communeId" INTEGER,
ADD COLUMN "email" TEXT,
ADD COLUMN "nameAr" TEXT,
ADD COLUMN "wilayaId" INTEGER;

-- Mettre wilayaId = 16 (Alger) pour toutes les branches existantes
UPDATE "branches" SET "wilayaId" = 16 WHERE "wilayaId" IS NULL;

-- Maintenant rendre wilayaId NOT NULL
ALTER TABLE "branches" ALTER COLUMN "wilayaId" SET NOT NULL;

-- AlterTable organizations
ALTER TABLE "organizations" DROP COLUMN "city",
DROP COLUMN "country",
ADD COLUMN "description" TEXT,
ADD COLUMN "nameAr" TEXT,
ADD COLUMN "website" TEXT,
DROP COLUMN "type",
ADD COLUMN "type" "OrgType" NOT NULL DEFAULT 'other';

-- AlterTable services
ALTER TABLE "services" ADD COLUMN "nameAr" TEXT;

-- CreateIndex
CREATE INDEX "branches_wilayaId_idx" ON "branches"("wilayaId");
CREATE INDEX "branches_communeId_idx" ON "branches"("communeId");
CREATE INDEX "organizations_type_idx" ON "organizations"("type");

-- AddForeignKey branches -> wilayas
ALTER TABLE "branches" ADD CONSTRAINT "branches_wilayaId_fkey" FOREIGN KEY ("wilayaId") REFERENCES "wilayas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey branches -> communes
ALTER TABLE "branches" ADD CONSTRAINT "branches_communeId_fkey" FOREIGN KEY ("communeId") REFERENCES "communes"("id") ON DELETE SET NULL ON UPDATE CASCADE;
