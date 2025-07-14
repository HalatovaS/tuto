#include "/pbs/home/o/ohalatova/MiModule/include/MiEvent.h"
#include <iostream>
#include "TObject.h"
#include "vector"


R__LOAD_LIBRARY(/pbs/home/o/ohalatova/MiModule/lib/libMiModule.so);

void Cuts_CalcTl208()
{
	TFile* f = new TFile("/pbs/home/o/ohalatova/tutorial/Tl208/Default.root");
	TTree* s = (TTree*) f->Get("Event");
	

	
int N = s->GetEntries();

std::cout << "Number of entries in tree: " << N << std::endl; 

int passed1 = 0;
int passed2 = 0;
int passed3 = 0;
int passed4 = 0;
int n_calos;
int n_tracks;
int negTracks;
double totEnergy;

	MiEvent* Eve = new MiEvent();
	s->SetBranchAddress("Eventdata", &Eve);
	n_calos = 0;
	
	 for (UInt_t i = 0; i < N; i++)
	{
		s->GetEntry(i);
		n_calos = Eve->getCD()->getnoofcaloh();
		std::cout << "Number of calo hits: " << n_calos << std::endl;
		if (n_calos == 2) passed1++;
		

vector<MiCDParticle>* particles = Eve->getPTD()->getpartv();

 n_tracks = 0; 
 negTracks =0;
 
  for (size_t j = 0; j < particles->size(); j++)
  {
  	MiCDParticle* particle = &particles->at(j);
  	
  	bool isReconstructed = !particle->getcalohitv()->empty() || !particle->getvertexv()->empty();
  	
  	if (isReconstructed)
  	{
  		n_tracks++;
  		if (particle->getcharge() < 0) negTracks++;
  	}
  }
  
  std::cout << "Number of reconstructed tracks: " << n_tracks << std::endl;
  std::cout << "Number of negative tracks: " << negTracks << std::endl;
  
  if (n_calos == 2 && n_tracks == 2) passed2++;
  if (n_calos == 2 && n_tracks == 2 && negTracks == 2) passed3++;


	totEnergy = 0.0;
	for (int i = 0; i < Eve->getCD()->getnoofcaloh(); i++)
	{
		MiCDCaloHit* caloHit = Eve->getCD()->getcalohit(i);
		totEnergy += caloHit->getE();
	}
	
	std::cout << "Total energy: " << totEnergy << " eV" << std::endl;
	
	if (n_calos == 2 && n_tracks == 2 && negTracks == 2 && totEnergy >= 2000.0) passed4++;
  }
 
 cout << "eps1 = " << (100.0 * passed1)/N << "% +- " << (100.0 * sqrt(double(passed1)))/N << "%" << endl;
 cout << "eps2 = " << (100.0 * passed2)/N << "% +- " << (100.0 * sqrt(double(passed2)))/N << "%" << endl;
 cout << "eps3 = " << (100.0 * passed3)/N << "% +- " << (100.0 * sqrt(double(passed3)))/N << "%" << endl;
 cout << "eps4 = " << (100.0 * passed4)/N << "% +- " << (100.0 * sqrt(double(passed4)))/N << "%" << endl;
 }
