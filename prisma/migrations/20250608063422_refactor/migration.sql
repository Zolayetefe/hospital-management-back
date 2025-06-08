/*
  Warnings:

  - The primary key for the `Doctor` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Doctor` table. All the data in the column will be lost.
  - The primary key for the `FinanceStaff` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `FinanceStaff` table. All the data in the column will be lost.
  - You are about to drop the column `approvalStatus` on the `LabRequest` table. All the data in the column will be lost.
  - The primary key for the `LabTechnician` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `LabTechnician` table. All the data in the column will be lost.
  - You are about to drop the column `approvalStatus` on the `LabTestBill` table. All the data in the column will be lost.
  - You are about to alter the column `totalAmount` on the `LabTestBill` table. The data in that column could be lost. The data in that column will be cast from `DoublePrecision` to `Decimal(65,30)`.
  - You are about to drop the column `labResultIds` on the `MedicalRecord` table. All the data in the column will be lost.
  - You are about to drop the column `prescriptionIds` on the `MedicalRecord` table. All the data in the column will be lost.
  - You are about to drop the column `triageIds` on the `MedicalRecord` table. All the data in the column will be lost.
  - You are about to drop the column `approvalStatus` on the `MedicationBill` table. All the data in the column will be lost.
  - You are about to alter the column `totalAmount` on the `MedicationBill` table. The data in that column could be lost. The data in that column will be cast from `DoublePrecision` to `Decimal(65,30)`.
  - The primary key for the `Nurse` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Nurse` table. All the data in the column will be lost.
  - The primary key for the `Patient` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `dateOfBirth` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `emergencyContact` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `Patient` table. All the data in the column will be lost.
  - The primary key for the `Pharmacist` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Pharmacist` table. All the data in the column will be lost.
  - You are about to drop the column `approvalStatus` on the `Prescription` table. All the data in the column will be lost.
  - The primary key for the `Receptionist` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Receptionist` table. All the data in the column will be lost.
  - You are about to drop the `AppointmentFinance` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `DoctorSlot` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[visitId]` on the table `Appointment` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[visitId]` on the table `MedicalRecord` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[triageId]` on the table `MedicalRecord` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[prescriptionId]` on the table `MedicalRecord` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[labResultId]` on the table `MedicalRecord` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[prescriptionId]` on the table `MedicationBill` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[nationalId]` on the table `Patient` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `updatedAt` to the `Appointment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Dispense` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `medications` on the `Dispense` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Made the column `notes` on table `Dispense` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `department` to the `Doctor` table without a default value. This is not possible if the table is not empty.
  - Added the required column `officeNumber` to the `Doctor` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Doctor` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `DoctorAvailability` table without a default value. This is not possible if the table is not empty.
  - Added the required column `officeNumber` to the `FinanceStaff` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `FinanceStaff` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `LabRequest` table without a default value. This is not possible if the table is not empty.
  - Made the column `notes` on table `LabRequest` required. This step will fail if there are existing NULL values in that column.
  - Made the column `priority` on table `LabRequest` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `updatedAt` to the `LabResult` table without a default value. This is not possible if the table is not empty.
  - Made the column `notes` on table `LabResult` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `labSection` to the `LabTechnician` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `LabTechnician` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `LabTestBill` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `MedicalRecord` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `MedicationBill` table without a default value. This is not possible if the table is not empty.
  - Added the required column `officeNumber` to the `Nurse` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Nurse` table without a default value. This is not possible if the table is not empty.
  - Added the required column `birthDate` to the `Patient` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nationalId` to the `Patient` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Patient` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `gender` on the `Patient` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `updatedAt` to the `Pharmacist` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Prescription` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `medications` on the `Prescription` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Made the column `notes` on table `Prescription` required. This step will fail if there are existing NULL values in that column.
  - Made the column `dispenseStatus` on table `Prescription` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `updatedAt` to the `Receptionist` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Triage` table without a default value. This is not possible if the table is not empty.
  - Made the column `appointmentId` on table `Triage` required. This step will fail if there are existing NULL values in that column.
  - Made the column `nurseId` on table `Triage` required. This step will fail if there are existing NULL values in that column.
  - Changed the type of `symptoms` on the `Triage` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Made the column `vitals` on table `Triage` required. This step will fail if there are existing NULL values in that column.
  - Made the column `notes` on table `Triage` required. This step will fail if there are existing NULL values in that column.
  - Made the column `status` on table `User` required. This step will fail if there are existing NULL values in that column.

*/
-- CreateEnum
CREATE TYPE "PaymentApprovalStatus" AS ENUM ('pending', 'approved', 'rejected');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('male', 'female', 'other');

-- CreateEnum
CREATE TYPE "VisitStatus" AS ENUM ('queued', 'completed', 'cancelled');

-- CreateEnum
CREATE TYPE "InsuranceClaimStatus" AS ENUM ('pending', 'approved', 'rejected');

-- DropForeignKey
ALTER TABLE "Appointment" DROP CONSTRAINT "Appointment_doctorId_fkey";

-- DropForeignKey
ALTER TABLE "Appointment" DROP CONSTRAINT "Appointment_patientId_fkey";

-- DropForeignKey
ALTER TABLE "Appointment" DROP CONSTRAINT "Appointment_rescheduledFrom_fkey";

-- DropForeignKey
ALTER TABLE "AppointmentFinance" DROP CONSTRAINT "AppointmentFinance_appointmentId_fkey";

-- DropForeignKey
ALTER TABLE "AppointmentFinance" DROP CONSTRAINT "AppointmentFinance_financeStaffId_fkey";

-- DropForeignKey
ALTER TABLE "Dispense" DROP CONSTRAINT "Dispense_patientId_fkey";

-- DropForeignKey
ALTER TABLE "Dispense" DROP CONSTRAINT "Dispense_pharmacistId_fkey";

-- DropForeignKey
ALTER TABLE "DoctorAvailability" DROP CONSTRAINT "DoctorAvailability_doctorId_fkey";

-- DropForeignKey
ALTER TABLE "DoctorSlot" DROP CONSTRAINT "DoctorSlot_doctorId_fkey";

-- DropForeignKey
ALTER TABLE "LabRequest" DROP CONSTRAINT "LabRequest_doctorId_fkey";

-- DropForeignKey
ALTER TABLE "LabRequest" DROP CONSTRAINT "LabRequest_patientId_fkey";

-- DropForeignKey
ALTER TABLE "LabResult" DROP CONSTRAINT "LabResult_labRequestId_fkey";

-- DropForeignKey
ALTER TABLE "LabResult" DROP CONSTRAINT "LabResult_labTechnicianId_fkey";

-- DropForeignKey
ALTER TABLE "LabTestBill" DROP CONSTRAINT "LabTestBill_financeStaffId_fkey";

-- DropForeignKey
ALTER TABLE "LabTestBill" DROP CONSTRAINT "LabTestBill_patientId_fkey";

-- DropForeignKey
ALTER TABLE "MedicalRecord" DROP CONSTRAINT "MedicalRecord_patientId_fkey";

-- DropForeignKey
ALTER TABLE "MedicationBill" DROP CONSTRAINT "MedicationBill_financeStaffId_fkey";

-- DropForeignKey
ALTER TABLE "MedicationBill" DROP CONSTRAINT "MedicationBill_patientId_fkey";

-- DropForeignKey
ALTER TABLE "Prescription" DROP CONSTRAINT "Prescription_doctorId_fkey";

-- DropForeignKey
ALTER TABLE "Prescription" DROP CONSTRAINT "Prescription_patientId_fkey";

-- DropForeignKey
ALTER TABLE "Triage" DROP CONSTRAINT "Triage_nurseId_fkey";

-- DropForeignKey
ALTER TABLE "Triage" DROP CONSTRAINT "Triage_patientId_fkey";

-- DropIndex
DROP INDEX "Doctor_userId_key";

-- DropIndex
DROP INDEX "FinanceStaff_userId_key";

-- DropIndex
DROP INDEX "LabTechnician_userId_key";

-- DropIndex
DROP INDEX "MedicalRecord_patientId_key";

-- DropIndex
DROP INDEX "Nurse_userId_key";

-- DropIndex
DROP INDEX "Patient_userId_key";

-- DropIndex
DROP INDEX "Pharmacist_userId_key";

-- DropIndex
DROP INDEX "Receptionist_userId_key";

-- AlterTable
ALTER TABLE "Appointment" ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "triageId" TEXT,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "visitId" TEXT,
ALTER COLUMN "status" SET DEFAULT 'pending';

-- AlterTable
ALTER TABLE "Dispense" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
DROP COLUMN "medications",
ADD COLUMN     "medications" JSONB NOT NULL,
ALTER COLUMN "notes" SET NOT NULL;

-- AlterTable
ALTER TABLE "Doctor" DROP CONSTRAINT "Doctor_pkey",
DROP COLUMN "id",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "department" TEXT NOT NULL,
ADD COLUMN     "officeNumber" TEXT NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ADD CONSTRAINT "Doctor_pkey" PRIMARY KEY ("userId");

-- AlterTable
ALTER TABLE "DoctorAvailability" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "FinanceStaff" DROP CONSTRAINT "FinanceStaff_pkey",
DROP COLUMN "id",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "officeNumber" TEXT NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ADD CONSTRAINT "FinanceStaff_pkey" PRIMARY KEY ("userId");

-- AlterTable
ALTER TABLE "LabRequest" DROP COLUMN "approvalStatus",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "notes" SET NOT NULL,
ALTER COLUMN "priority" SET NOT NULL;

-- AlterTable
ALTER TABLE "LabResult" ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "notes" SET NOT NULL;

-- AlterTable
ALTER TABLE "LabTechnician" DROP CONSTRAINT "LabTechnician_pkey",
DROP COLUMN "id",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "labSection" TEXT NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ADD CONSTRAINT "LabTechnician_pkey" PRIMARY KEY ("userId");

-- AlterTable
ALTER TABLE "LabTestBill" DROP COLUMN "approvalStatus",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "status" "PaymentApprovalStatus" NOT NULL DEFAULT 'pending',
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "totalAmount" SET DATA TYPE DECIMAL(65,30),
ALTER COLUMN "paidAt" DROP NOT NULL,
ALTER COLUMN "paidAt" DROP DEFAULT;

-- AlterTable
ALTER TABLE "MedicalRecord" DROP COLUMN "labResultIds",
DROP COLUMN "prescriptionIds",
DROP COLUMN "triageIds",
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "diagnoses" TEXT,
ADD COLUMN     "labResultId" TEXT,
ADD COLUMN     "notes" TEXT,
ADD COLUMN     "prescriptionId" TEXT,
ADD COLUMN     "triageId" TEXT,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "visitId" TEXT;

-- AlterTable
ALTER TABLE "MedicationBill" DROP COLUMN "approvalStatus",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "status" "PaymentApprovalStatus" NOT NULL DEFAULT 'pending',
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "totalAmount" SET DATA TYPE DECIMAL(65,30),
ALTER COLUMN "paidAt" DROP NOT NULL,
ALTER COLUMN "paidAt" DROP DEFAULT;

-- AlterTable
ALTER TABLE "Nurse" DROP CONSTRAINT "Nurse_pkey",
DROP COLUMN "id",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "officeNumber" TEXT NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ADD CONSTRAINT "Nurse_pkey" PRIMARY KEY ("userId");

-- AlterTable
ALTER TABLE "Patient" DROP CONSTRAINT "Patient_pkey",
DROP COLUMN "dateOfBirth",
DROP COLUMN "emergencyContact",
DROP COLUMN "id",
ADD COLUMN     "birthDate" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "nationalId" TEXT NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
DROP COLUMN "gender",
ADD COLUMN     "gender" "Gender" NOT NULL,
ADD CONSTRAINT "Patient_pkey" PRIMARY KEY ("userId");

-- AlterTable
ALTER TABLE "Pharmacist" DROP CONSTRAINT "Pharmacist_pkey",
DROP COLUMN "id",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ADD CONSTRAINT "Pharmacist_pkey" PRIMARY KEY ("userId");

-- AlterTable
ALTER TABLE "Prescription" DROP COLUMN "approvalStatus",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
DROP COLUMN "medications",
ADD COLUMN     "medications" JSONB NOT NULL,
ALTER COLUMN "notes" SET NOT NULL,
ALTER COLUMN "dispenseStatus" SET NOT NULL;

-- AlterTable
ALTER TABLE "Receptionist" DROP CONSTRAINT "Receptionist_pkey",
DROP COLUMN "id",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ADD CONSTRAINT "Receptionist_pkey" PRIMARY KEY ("userId");

-- AlterTable
ALTER TABLE "Triage" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "appointmentId" SET NOT NULL,
ALTER COLUMN "nurseId" SET NOT NULL,
DROP COLUMN "symptoms",
ADD COLUMN     "symptoms" JSONB NOT NULL,
ALTER COLUMN "vitals" SET NOT NULL,
ALTER COLUMN "notes" SET NOT NULL;

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "deletedAt" TIMESTAMP(3),
ALTER COLUMN "status" SET NOT NULL;

-- DropTable
DROP TABLE "AppointmentFinance";

-- DropTable
DROP TABLE "DoctorSlot";

-- DropEnum
DROP TYPE "ApprovalStatus";

-- CreateTable
CREATE TABLE "AppointmentBill" (
    "id" TEXT NOT NULL,
    "appointmentId" TEXT NOT NULL,
    "amount" DECIMAL(65,30) NOT NULL,
    "status" "PaymentApprovalStatus" NOT NULL DEFAULT 'pending',
    "financeStaffId" TEXT NOT NULL,
    "approvedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "AppointmentBill_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InsuranceClaim" (
    "id" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,
    "financeStaffId" TEXT NOT NULL,
    "insuranceType" TEXT NOT NULL,
    "claimDetails" JSONB NOT NULL,
    "claimStatus" "InsuranceClaimStatus" NOT NULL DEFAULT 'pending',
    "submittedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "processedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "InsuranceClaim_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Visit" (
    "id" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,
    "receptionistId" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "visitDateTime" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" "VisitStatus" NOT NULL DEFAULT 'queued',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "Visit_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "AppointmentBill_appointmentId_key" ON "AppointmentBill"("appointmentId");

-- CreateIndex
CREATE INDEX "Visit_status_idx" ON "Visit"("status");

-- CreateIndex
CREATE INDEX "Visit_visitDateTime_idx" ON "Visit"("visitDateTime");

-- CreateIndex
CREATE UNIQUE INDEX "Appointment_visitId_key" ON "Appointment"("visitId");

-- CreateIndex
CREATE INDEX "Appointment_status_idx" ON "Appointment"("status");

-- CreateIndex
CREATE INDEX "Appointment_dateTime_idx" ON "Appointment"("dateTime");

-- CreateIndex
CREATE UNIQUE INDEX "MedicalRecord_visitId_key" ON "MedicalRecord"("visitId");

-- CreateIndex
CREATE UNIQUE INDEX "MedicalRecord_triageId_key" ON "MedicalRecord"("triageId");

-- CreateIndex
CREATE UNIQUE INDEX "MedicalRecord_prescriptionId_key" ON "MedicalRecord"("prescriptionId");

-- CreateIndex
CREATE UNIQUE INDEX "MedicalRecord_labResultId_key" ON "MedicalRecord"("labResultId");

-- CreateIndex
CREATE UNIQUE INDEX "MedicationBill_prescriptionId_key" ON "MedicationBill"("prescriptionId");

-- CreateIndex
CREATE UNIQUE INDEX "Patient_nationalId_key" ON "Patient"("nationalId");

-- AddForeignKey
ALTER TABLE "DoctorAvailability" ADD CONSTRAINT "DoctorAvailability_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES "Doctor"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appointment" ADD CONSTRAINT "Appointment_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appointment" ADD CONSTRAINT "Appointment_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES "Doctor"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appointment" ADD CONSTRAINT "Appointment_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES "Visit"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AppointmentBill" ADD CONSTRAINT "AppointmentBill_appointmentId_fkey" FOREIGN KEY ("appointmentId") REFERENCES "Appointment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AppointmentBill" ADD CONSTRAINT "AppointmentBill_financeStaffId_fkey" FOREIGN KEY ("financeStaffId") REFERENCES "FinanceStaff"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Triage" ADD CONSTRAINT "Triage_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Triage" ADD CONSTRAINT "Triage_nurseId_fkey" FOREIGN KEY ("nurseId") REFERENCES "Nurse"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Prescription" ADD CONSTRAINT "Prescription_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES "Doctor"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Prescription" ADD CONSTRAINT "Prescription_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabRequest" ADD CONSTRAINT "LabRequest_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES "Doctor"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabRequest" ADD CONSTRAINT "LabRequest_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabResult" ADD CONSTRAINT "LabResult_labRequestId_fkey" FOREIGN KEY ("labRequestId") REFERENCES "LabRequest"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabResult" ADD CONSTRAINT "LabResult_labTechnicianId_fkey" FOREIGN KEY ("labTechnicianId") REFERENCES "LabTechnician"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicationBill" ADD CONSTRAINT "MedicationBill_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicationBill" ADD CONSTRAINT "MedicationBill_financeStaffId_fkey" FOREIGN KEY ("financeStaffId") REFERENCES "FinanceStaff"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTestBill" ADD CONSTRAINT "LabTestBill_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTestBill" ADD CONSTRAINT "LabTestBill_financeStaffId_fkey" FOREIGN KEY ("financeStaffId") REFERENCES "FinanceStaff"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InsuranceClaim" ADD CONSTRAINT "InsuranceClaim_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InsuranceClaim" ADD CONSTRAINT "InsuranceClaim_financeStaffId_fkey" FOREIGN KEY ("financeStaffId") REFERENCES "FinanceStaff"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicalRecord" ADD CONSTRAINT "MedicalRecord_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicalRecord" ADD CONSTRAINT "MedicalRecord_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES "Visit"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicalRecord" ADD CONSTRAINT "MedicalRecord_prescriptionId_fkey" FOREIGN KEY ("prescriptionId") REFERENCES "Prescription"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicalRecord" ADD CONSTRAINT "MedicalRecord_labResultId_fkey" FOREIGN KEY ("labResultId") REFERENCES "LabResult"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicalRecord" ADD CONSTRAINT "MedicalRecord_triageId_fkey" FOREIGN KEY ("triageId") REFERENCES "Triage"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dispense" ADD CONSTRAINT "Dispense_pharmacistId_fkey" FOREIGN KEY ("pharmacistId") REFERENCES "Pharmacist"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dispense" ADD CONSTRAINT "Dispense_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Visit" ADD CONSTRAINT "Visit_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Visit" ADD CONSTRAINT "Visit_receptionistId_fkey" FOREIGN KEY ("receptionistId") REFERENCES "Receptionist"("userId") ON DELETE CASCADE ON UPDATE CASCADE;
