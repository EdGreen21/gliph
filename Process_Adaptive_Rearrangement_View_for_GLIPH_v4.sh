#!/usr/bin/env bash
#### Description: Script that adapts Adaptive sequence for input into GLIPH
#### Requires an input file
#### 
#### Invoke as: Process_Adaptive_Rearrangement_View_for_GLIPH_v3 < inputfile.txt > GLIPH_input.txt 2> stderrfile &
####
#### Written by: Ed Green - e.green@dkfz.de on 07-2017

#ERROR CHECKING - if a single command fails, the whole script ends.  Must have correct files installed
#load error checking script that returns error line
#see http://stackoverflow.com/questions/64786/error-handling-in-bash
#set -e
#source 'lib.trap.sh'


#Data structure for input into GLIPH - columns must be tab separated
#($CDR3b,$TRBV,$TRBJ,$CDR3a,$TRAV,$TRAJ,$patient,$counts)=
#CASSMGDERLFF		TCRBV19-01			TCRBJ01-04			xxxx_alpha		TCRAV-unknown	TCRAJ-unknown	C57BL6				
#0					1					2					3				4				5				6					
#${INPUT_FILE[3]}	${INPUT_FILE[5]}	${INPUT_FILE[7]}	"CDR3a_unknown"	"TCRAV-unknown"	"TCRAV-unknown"	${INPUT_FILE[0]}


##Data structure in Adaptive v3 'Rearrangement Details' and 'Export sample v1'
#sample_name		prod_freq	temp	amino_acid		rearrangement	v_resolved		d_resolved		j_resolved
#BALB_C-Thymus-1	0.414681	789		CASGDAQYEQYF	AACTTCT			TCRBV13-02*01	TCBDD01-01*01	TCRBJ02-07*01
#0					1			2		3				4				5				6				7																				

#delete header and then make copies of each TCR equal to number of templates
sed 1d $INPUT_FILE | while read -a INPUT_FILE; do
	yes ${INPUT_FILE[3]}$'\t'${INPUT_FILE[5]}$'\t'${INPUT_FILE[7]}$'\t'"CDR3a_unknown"$'\t'"TCRAV-unknown"$'\t'"TCRAJ-unknown"$'\t'${INPUT_FILE[0]} | head -n ${INPUT_FILE[2]}
done




## Adaptive v2 export  format
#nucleotide		aminoAcid	count (templates/reads)	frequencyCount (%)	cdr3Length	vMaxResolved	vFamilyName	vGeneName	vGeneAllele	vFamilyTies	
#0				1			2						3					4			5				6			7			8			9			
#vGeneNameTies	vGeneAlleleTies	dMaxResolved	dFamilyName	dGeneName	dGeneAllele	dFamilyTies	dGeneNameTies	dGeneAlleleTies	jMaxResolved	
#10				11				12				13			14			15			16			17				18				19
#jFamilyName	jGeneName	jGeneAllele	jFamilyTies	jGeneNameTies	jGeneAlleleTies	vDeletion	n1Insertion	d5Deletion	d3Deletion	n2Insertion	
#20				21			22			23			24				25				26			27			28			29			30			
#jDeletion	vIndex	n1Index	dIndex	n2Index	jIndex	estimatedNumberGenomes	sequenceStatus	cloneResolved	vOrphon	dOrphon	jOrphon	vFunction	
#31			32		33		34		35		36		37						38				39				40		41		42		43	
#dFunction	jFunction	fractionNucleated	vAlignLength	vAlignSubstitutionCount	vAlignSubstitutionIndexes	vAlignSubstitutionGeneThreePrimeIndexes	
#44			45			46					47				48						49							50
#vSeqWithMutations
#51

#($CDR3b,$TRBV,$TRBJ,$CDR3a,$TRAV,$TRAJ,$patient,$counts)=
#CASSMGDERLFF		TCRBV19-01			TCRBJ01-04			xxxx_alpha		TCRAV-unknown	TCRAJ-unknown	C57BL6				32
#0					1					2					3				4				5				6					7
#${INPUT_FILE[1]}$'\t'${INPUT_FILE[7]}$'\t'${INPUT_FILE[21]}$'\t'"CDR3a_unknown"$'\t'"TCRAV-unknown"$'\t'"TCRAV-unknown"$'\t'$INPUT_FILE$'\t'${INPUT_FILE[2]}

#delete header and then make copies of each TCR equal to number of templates
#sed 1d $INPUT_FILE | while read -a INPUT_FILE; do
#	yes ${INPUT_FILE[1]}$'\t'${INPUT_FILE[7]}$'\t'${INPUT_FILE[21]}$'\t'"CDR3a_unknown"$'\t'"TCRAV-unknown"$'\t'"TCRAV-unknown"$'\t'$INPUT_FILE$'\t'${INPUT_FILE[2]}
#done


