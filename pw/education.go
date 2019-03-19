package pw

// Education contains fields which pertain to education
type Education struct {
	Name           *string `yaml:"name"`
	Degree         *string `yaml:"degree"`
	Major          *string `yaml:"major"`
	GraduationYear *int16  `yaml:"grad-year"`
	URL            *string `yaml:"url"`
}
