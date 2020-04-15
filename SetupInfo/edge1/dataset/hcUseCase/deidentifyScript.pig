REGISTER decript.jar;

A = LOAD 'file:///home/mohit/Downloads/dataset/hcUseCase/healthcare_Sample_dataset2.csv' using PigStorage(',') AS (PatientID: int, Name: chararray, DOB: chararray, PhoneNumber: chararray, EmailAddress: chararray, SSN: chararray, Gender: chararray, Disease: chararray, weight: float);

B = LOAD 'file:///home/mohit/Downloads/dataset/hcUseCase/healthcare_Sample_dataset1.csv' using PigStorage(',') AS (PatientID: int, Name: chararray, DOB: chararray, PhoneNumber: chararray, EmailAddress: chararray, SSN: chararray, Gender: chararray, Disease: chararray, weight: float);

C = UNION A, B;

D = FOREACH C GENERATE PatientID, DeIdentifyUDF(Name,'12345678abcdefgh'), DeIdentifyUDF(DOB,'12345678abcdefgh'), DeIdentifyUDF(PhoneNumber,'12345678abcdefgh'), DeIdentifyUDF(EmailAddress,'12345678abcdefgh'),DeIdentifyUDF(SSN,'12345678abcdefgh'), DeIdentifyUDF(Disease,'12345678abcdefgh'),weight;

STORE D into 'file:///home/mohit/Downloads/dataset/deidentifiedDir';
