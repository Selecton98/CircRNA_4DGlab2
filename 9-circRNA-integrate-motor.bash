#!/bin/bash
Rscript /together_sdb/zhoujiaqi/ICCcircexosome/wxz-circRNA-integrate.R --max-ppsize=500000

sed -i "s/H1/H2/g"  /together_sdb/zhoujiaqi/ICCcircexosome/wxz-circRNA-integrate.R
Rscript /together_sdb/zhoujiaqi/ICCcircexosome/wxz-circRNA-integrate.R --max-ppsize=500000

sed -i "s/H2/H5/g"  /together_sdb/zhoujiaqi/ICCcircexosome/wxz-circRNA-integrate.R
Rscript /together_sdb/zhoujiaqi/ICCcircexosome/wxz-circRNA-integrate.R --max-ppsize=500000

sed -i "s/H5/H7/g"  /together_sdb/zhoujiaqi/ICCcircexosome/wxz-circRNA-integrate.R
Rscript /together_sdb/zhoujiaqi/ICCcircexosome/wxz-circRNA-integrate.R --max-ppsize=500000

sed -i "s/H7/Q3/g"  /together_sdb/zhoujiaqi/ICCcircexosome/wxz-circRNA-integrate.R
Rscript /together_sdb/zhoujiaqi/ICCcircexosome/wxz-circRNA-integrate.R --max-ppsize=500000

sed -i "s/Q3/Q5/g"  /together_sdb/zhoujiaqi/ICCcircexosome/wxz-circRNA-integrate.R
Rscript /together_sdb/zhoujiaqi/ICCcircexosome/wxz-circRNA-integrate.R --max-ppsize=500000

sed -i "s/Q5/Q8/g"  /together_sdb/zhoujiaqi/ICCcircexosome/wxz-circRNA-integrate.R
Rscript /together_sdb/zhoujiaqi/ICCcircexosome/wxz-circRNA-integrate.R --max-ppsize=500000

sed -i "s/Q8/Q9/g"  /together_sdb/zhoujiaqi/ICCcircexosome/wxz-circRNA-integrate.R
Rscript /together_sdb/zhoujiaqi/ICCcircexosome/wxz-circRNA-integrate.R --max-ppsize=500000
