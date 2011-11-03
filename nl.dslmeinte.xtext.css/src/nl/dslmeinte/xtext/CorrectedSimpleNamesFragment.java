package nl.dslmeinte.xtext;

import java.util.Set;

import org.eclipse.xtext.Grammar;
import org.eclipse.xtext.generator.BindFactory;
import org.eclipse.xtext.generator.Binding;
import org.eclipse.xtext.generator.DefaultGeneratorFragment;
import org.eclipse.xtext.naming.IQualifiedNameProvider;
import org.eclipse.xtext.naming.SimpleNameProvider;

public class CorrectedSimpleNamesFragment extends DefaultGeneratorFragment {

	@Override
	public Set<Binding> getGuiceBindingsRt(Grammar grammar) {
		return new BindFactory()
			.addfinalTypeToType(IQualifiedNameProvider.class.getName(), SimpleNameProvider.class.getName())
			.getBindings();
	}

	@Override
	public Set<Binding> getGuiceBindingsUi(Grammar grammar) {
		return new BindFactory()
			// changed original line to match lines 35-36 in QualifiedNamesFragment
			.addTypeToType("org.eclipse.xtext.ui.refactoring.IDependentElementsCalculator",
					"org.eclipse.xtext.ui.refactoring.impl.DefaultDependentElementsCalculator")
			.getBindings();
	}

}
