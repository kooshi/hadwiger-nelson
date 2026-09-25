# Builds data/m2/j16/Combined.lean: UnitRing.lean + Instances/SevenUnitRing.lean in one scratch file,
# so the instance can be elaborated before UnitRing has an .olean (lake env lean builds nothing).
a=open('Proofs/HadwigerNelson/UnitRing.lean').read().replace("import Proofs.HadwigerNelson.Chain\n","")
b=open('Proofs/HadwigerNelson/Instances/SevenUnitRing.lean').read()
b=b.replace("import Proofs.HadwigerNelson.UnitRing\n","").replace("import Proofs.HadwigerNelson.Instances.SevenConditional\n","")
open('data/m2/j16/Combined.lean','w').write("import Proofs.HadwigerNelson.Instances.SevenConditional\n"+a+"\n"+b)
